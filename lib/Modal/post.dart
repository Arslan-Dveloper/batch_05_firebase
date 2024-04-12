class PostModal {
  String? id;
  String? title;
  String? body;
  String? userId;

  PostModal({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
    };
  }

  factory PostModal.fromMap(Map<String, dynamic> map) {
    return PostModal(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      userId: map['userId'] ?? '',
    );
  }
}
