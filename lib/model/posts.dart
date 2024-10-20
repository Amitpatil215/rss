class PostsModel {
  final String? text;
  final String? desc;
  final String? id;
  final String? url;
  final DateTime? createdAt;
  final DateTime? lastSeen;
  final String? type;
  final int? commentCount;
  final String? status; // Pending, Completed, Snoozed
  final DateTime? dueDate;

  PostsModel({
    this.text,
    this.desc,
    this.id,
    this.url,
    this.createdAt,
    this.lastSeen,
    this.status,
    this.dueDate,
    this.type,
    this.commentCount,
  });

  // Factory constructor for creating a new PostsModel instance from a map
  factory PostsModel.fromJson(Map<String, dynamic> json, String docId) {
    return PostsModel(
      text: json['text'] as String?,
      desc: json['desc'] as String?,
      id: docId,
      url: json['url'] as String?,
      createdAt: json['created_at']?.toDate() as DateTime?,
      lastSeen: json['last_seen']?.toDate() as DateTime?,
      status: json['status'] as String?,
      dueDate: json['due_date']?.toDate() as DateTime?,
      type: json['type'] as String?,
      commentCount: json['comment_count'] as int?,
    );
  }

  // Method for converting a PostsModel instance into a map
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'desc': desc,
      'id': id,
      'url': url,
      'created_at': createdAt,
      'last_seen': lastSeen,
      'status': status,
      'due_date': dueDate,
      'type': type,
      'comment_count': commentCount
    };
  }

  // to JSON only no null values
  Map<String, dynamic> toJsonNoNull() {
    return {
      'text': text,
      'desc': desc,
      'id': id,
      'url': url,
      'created_at': createdAt,
      'last_seen': lastSeen,
      'status': status,
      'due_date': dueDate,
      'type': type,
      'comment_count': commentCount,
    }.withoutNulls();
  }

  @override
  String toString() {
    return 'PostsModel{text: $text, desc: $desc, id: $id, url: $url, createdAt: $createdAt, lastSeen: $lastSeen, status: $status, dueDate: $dueDate, type: $type, commentCount: $commentCount}';
  }
}

extension MapUtils<K, V> on Map<K, V> {
  /// Removes all entries in the map that have null values.
  Map<K, V> withoutNulls() {
    // Create a new map that includes only key-value pairs where the value is not null.
    return Map.fromEntries(entries.where((entry) => entry.value != null));
  }
}
