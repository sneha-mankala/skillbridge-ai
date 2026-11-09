
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  static Future<Map<String, dynamic>> checkBackend() async {
    final response = await http
        .get(Uri.parse('$baseUrl/api/health'))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw Exception('Backend connection failed');
  }

  static Future<Map<String, dynamic>> analyzeSkills({
    required String targetRole,
    required List<String> skills,
  }) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/api/skills/analyze'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'target_role': targetRole,
            'skills': skills,
          }),
        )
        .timeout(const Duration(seconds: 20));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw Exception('Skill analysis failed: ${response.statusCode}');
  }
}
