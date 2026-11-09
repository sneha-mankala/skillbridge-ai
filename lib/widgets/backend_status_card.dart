
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class BackendStatusCard extends StatefulWidget {
  const BackendStatusCard({super.key});

  @override
  State<BackendStatusCard> createState() =>
      _BackendStatusCardState();
}

class _BackendStatusCardState extends State<BackendStatusCard> {
  late Future<Map<String, dynamic>> backendStatus;

  @override
  void initState() {
    super.initState();
    backendStatus = ApiService.checkBackend();
  }

  void checkAgain() {
    setState(() {
      backendStatus = ApiService.checkBackend();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: FutureBuilder<Map<String, dynamic>>(
          future: backendStatus,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 15),
                  Text('Connecting to Python backend...'),
                ],
              );
            }

            if (snapshot.hasError) {
              return Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text('Backend disconnected'),
                  ),
                  IconButton(
                    onPressed: checkAgain,
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              );
            }

            return Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Python Backend Connected!',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: checkAgain,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
