class Comment {
  String? userId;
  String? id;
  String? postId;
  String? body;
  int? timeStamp;

  Comment({
    required this.userId,
    required this.id,
    required this.postId,
    required this.body,
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'postId': postId,
      'body': body,
      'timeStamp': timeStamp
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      userId: map['userId'],
      id: map['id'],
      postId: map['postId'],
      body: map['body'],
      timeStamp: map['timeStamp'],
    );
  }
}
