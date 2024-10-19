import 'dart:convert'; // For jsonEncode and jsonDecode
import 'package:http/http.dart' as http; // Import the http package

class TaskResponse {
  String? dueDate;
  String? url;
  String? type;
  String? title;
  String? desc;

  // Constructor
  TaskResponse({this.dueDate, this.url, this.type, this.title, this.desc});

  // fromJson factory constructor
  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      dueDate: json['due_date'] as String?,
      url: json['url'] as String?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      desc: json['desc'] as String?,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'due_date': dueDate,
      'url': url,
      'type': type,
      'title': title,
      'desc': desc,
    };
  }

  @override
  String toString() {
    return 'TaskResponse{dueDate: $dueDate, url: $url, type: $type, title: $title, desc: $desc}';
  }
}
