import 'package:batch_05_firebase/Modal/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScreenPostByUser extends StatelessWidget {
  String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('post')
            .where('userId', isEqualTo: userId)
            .get(),
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
              return ListTile(
                title: Text('${post.title}'),
                subtitle: Text(post.body.toString()),
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
