class CommentModel {
  final String? text;
  final String? id;
  final DateTime? createdAt;

  CommentModel({this.text, this.id, this.createdAt, s});

  // Factory constructor for creating a new CommentModel instance from a map
  factory CommentModel.fromJson(Map<String, dynamic> json, String docId) {
    return CommentModel(
      text: json['text'] as String?,
      id: docId,
      createdAt: json['created_at']?.toDate() as DateTime?,
    );
  }

  // Method for converting a CommentModel instance into a map
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'id': id,
      'created_at': createdAt,
    };
  }

  // to JSON only no null values
  Map<String, dynamic> toJsonNoNull() {
    return {
      'text': text,
      'id': id,
      'created_at': createdAt,
    }.withoutNulls();
  }

  @override
  String toString() {
    return 'CommentModel{text: $text,  id: $id,  createdAt: $createdAt}';
  }
}

extension MapUtils<K, V> on Map<K, V> {
  /// Removes all entries in the map that have null values.
  Map<K, V> withoutNulls() {
    // Create a new map that includes only key-value pairs where the value is not null.
    return Map.fromEntries(entries.where((entry) => entry.value != null));
  }
}
