// Example function to fetch data from an API
import 'dart:convert';
// For jsonEncode and jsonDecode
import 'package:http/http.dart' as http;
import '../model/response_model/chatgpt_response.dart';

class APICalls {
  static const n8nFormattedTaskURL =
      'https://n8n.amiit.fyi/webhook/56884418-550e-4965-887d-135449fe2dc6';
  static Future<TaskResponse?> getFormattedTasks(String description) async {
    try {
      final response = await http.post(
        Uri.parse(n8nFormattedTaskURL),
        body: jsonEncode({'text': description}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Assuming the API response is a JSON object
        final Map<String, dynamic> data = jsonDecode(response.body);
        final task = TaskResponse.fromJson(data);

        print(task.toString());

        return task;
      } else {
        print('Failed to load task. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }

    return null;
  }
}
