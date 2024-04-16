import 'package:batch_05_firebase/Custom_Widgets/My_Custom_Widgets.dart';
import 'package:batch_05_firebase/Modal/comment.dart';
import 'package:batch_05_firebase/Modal/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScreenPostByUser extends StatelessWidget {
  String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          'Post by ${userId}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('post')
            .where('userId', isEqualTo: userId)
            .get(),
        // future: FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(userId)
        //     .collection('posts')
        //     .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Text('Some Thing went Wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              var post = PostModal.fromMap(data);
              return Card(
                child: ExpansionTile(
                  title: Text('${post.title}'),
                  subtitle: Text(post.body.toString()),
                  children: [
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('comments')
                          .where('postId', isEqualTo: post.id)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Something Went Wrong'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              var comment = Comment.fromMap(data);
                              return ListTile(
                                title: Text('${comment.body}'),
                                subtitle: Text('${comment.userId}'),
                              );
                            }).toList(),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    OutlinedButton(
                        onPressed: () {
                          var bodyController = TextEditingController();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Comment of ${post.title}'),
                                content: MyTextFormField(
                                  controllerTextField: bodyController,
                                  hintText: 'Comment Here',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      int timeStamp =
                                          DateTime.now().millisecondsSinceEpoch;
                                      var comment = Comment(
                                        userId: FirebaseAuth
                                            .instance.currentUser?.uid,
                                        id: timeStamp.toString(),
                                        postId: post.id,
                                        body: bodyController.text,
                                        timeStamp: timeStamp,
                                      );
                                      FirebaseFirestore.instance
                                          .collection('comments')
                                          .doc(comment.id)
                                          .set(comment.toMap());
                                      Navigator.pop(context);
                                    },
                                    child: Text('Post'),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Comment'))
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  ScreenPostByUser({
    required this.userId,
  });
}
