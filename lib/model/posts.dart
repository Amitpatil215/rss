import 'package:cloud_firestore/cloud_firestore.dart';

class PostsModel {
  final String? text;
  final String? id;
  final String? url;
  final Timestamp? createdAt;
  final Timestamp? lastSeen;
  final String? status; // Pending, Completed, Snoozed
  final Timestamp? dueDate;

  PostsModel({
    required this.text,
    required this.id,
    required this.url,
    required this.createdAt,
    required this.lastSeen,
    required this.status,
    required this.dueDate,
  });

  // Factory constructor for creating a new PostsModel instance from a map
  factory PostsModel.fromJson(Map<String, dynamic> json) {
    return PostsModel(
      text: json['text'] as String?,
      id: json['id'] as String?,
      url: json['url'] as String?,
      createdAt: json['created_at'] as Timestamp?,
      lastSeen: json['last_seen'] as Timestamp?,
      status: json['status'] as String?,
      dueDate: json['due_date'] as Timestamp?,
    );
  }

  // Method for converting a PostsModel instance into a map
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'id': id,
      'url': url,
      'created_at': createdAt,
      'last_seen': lastSeen,
      'status': status,
      'due_date': dueDate,
    };
  }
}
