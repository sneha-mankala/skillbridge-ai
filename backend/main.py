

from fastapi import FastAPI, UploadFile, File, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from pypdf import PdfReader
from docx import Document
from io import BytesIO

app = FastAPI(
    title="SkillBridge AI API",
    description="Career guidance, skill analysis and resume processing API",
    version="1.0.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

ROLE_SKILLS = {
    "software developer": [
        "python", "java", "data structures",
        "algorithms", "oops", "sql", "git"
    ],
    "frontend developer": [
        "html", "css", "javascript",
        "react", "git", "responsive design"
    ],
    "data analyst": [
        "python", "sql", "excel",
        "statistics", "power bi", "data visualization"
    ],
    "backend developer": [
        "python", "java", "sql",
        "api", "database", "git", "oops"
    ],
    "machine learning engineer": [
        "python", "statistics", "machine learning",
        "numpy", "pandas", "scikit-learn"
    ],
}

KNOWN_SKILLS = sorted({
    skill
    for skills in ROLE_SKILLS.values()
    for skill in skills
} | {
    "c", "c++", "flutter", "dart", "firebase",
    "html", "css", "javascript", "react",
    "node.js", "fastapi", "django", "flask",
    "spring boot", "mongodb", "postgresql",
    "mysql", "aws", "docker", "linux",
    "communication", "problem solving"
})


class SkillAnalysisRequest(BaseModel):
    target_role: str
    skills: list[str]


@app.get("/")
def home():
    return {"message": "Welcome to SkillBridge AI Backend!"}


@app.get("/api/health")
def health_check():
    return {
        "status": "success",
        "message": "SkillBridge AI backend is running!"
    }


@app.get("/api/roles")
def get_roles():
    return {"roles": list(ROLE_SKILLS.keys())}


@app.post("/api/skills/analyze")
def analyze_skills(request: SkillAnalysisRequest):
    role = request.target_role.strip().lower()

    if role not in ROLE_SKILLS:
        return {
            "status": "error",
            "message": "Role not supported yet.",
            "available_roles": list(ROLE_SKILLS.keys())
        }

    required_skills = ROLE_SKILLS[role]
    user_skills = {
        skill.strip().lower()
        for skill in request.skills
        if skill.strip()
    }

    matched_skills = [
        skill for skill in required_skills
        if skill in user_skills
    ]

    missing_skills = [
        skill for skill in required_skills
        if skill not in user_skills
    ]

    score = round(
        len(matched_skills) / len(required_skills) * 100
    )

    return {
        "status": "success",
        "target_role": role,
        "readiness_score": score,
        "matched_skills": matched_skills,
        "missing_skills": missing_skills,
        "total_required_skills": len(required_skills),
        "recommendation": (
            "You are well prepared!"
            if score >= 80
            else "Focus on learning the missing skills."
        )
    }


def extract_resume_text(filename: str, content: bytes) -> str:
    extension = filename.lower().rsplit(".", 1)[-1]

    try:
        if extension == "pdf":
            reader = PdfReader(BytesIO(content))
            return "\n".join(
                page.extract_text() or ""
                for page in reader.pages
            )

        if extension == "docx":
            document = Document(BytesIO(content))
            return "\n".join(
                paragraph.text
                for paragraph in document.paragraphs
            )

        if extension == "txt":
            return content.decode("utf-8-sig")

    except Exception as error:
        raise HTTPException(
            status_code=400,
            detail=f"Could not read resume: {error}"
        )

    raise HTTPException(
        status_code=400,
        detail="Only PDF, DOCX and TXT files are supported."
    )


@app.post("/api/resume/analyze")
async def analyze_resume(file: UploadFile = File(...)):
    if not file.filename:
        raise HTTPException(
            status_code=400,
            detail="Please select a resume file."
        )

    extension = file.filename.lower().rsplit(".", 1)[-1]

    if extension not in {"pdf", "docx", "txt"}:
        raise HTTPException(
            status_code=400,
            detail="Upload a PDF, DOCX or TXT file."
        )

    content = await file.read()

    if not content:
        raise HTTPException(
            status_code=400,
            detail="The uploaded file is empty."
        )

    if len(content) > 5 * 1024 * 1024:
        raise HTTPException(
            status_code=400,
            detail="File size must be 5 MB or less."
        )

    text = extract_resume_text(file.filename, content)

    if not text.strip():
        raise HTTPException(
            status_code=400,
            detail="No readable text found. Scanned PDFs need OCR."
        )

    text_lower = text.lower()

    extracted_skills = [
        skill for skill in KNOWN_SKILLS
        if skill in text_lower
    ]

    return {
        "status": "success",
        "filename": file.filename,
        "message": "Resume processed successfully.",
        "extracted_skills": extracted_skills,
        "total_skills": len(extracted_skills),
        "extracted_text": text[:10000]
    }
