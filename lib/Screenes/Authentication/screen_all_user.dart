import 'package:batch_05_firebase/Controllers/Authentication_Controller/User_Controller.dart';
import 'package:batch_05_firebase/Modal/post.dart';
import 'package:batch_05_firebase/Screenes/Authentication/screen_input_data.dart';
import 'package:batch_05_firebase/Screenes/Authentication/screen_post_by_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenAllUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userController = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      FirebaseAuth.instance.currentUser?.displayName ??
                          'No Display Name'),
                ),
              );
            },
            icon: Icon(Icons.info),
          ),
          IconButton(
            onPressed: () {
              userController.update();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var titleController = TextEditingController();
          var descriptionController = TextEditingController();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('New Post'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(hintText: 'Title'),
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(hintText: 'Description'),
                      )
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Cancal')),
                  TextButton(
                      onPressed: () {
                        Get.back();
                        var title = titleController.text;
                        var description = descriptionController.text;
                        var postModal = PostModal(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: title,
                          body: description,
                          userId: FirebaseAuth.instance.currentUser!.uid,
                        );
                        userController.addPost(postModal).then((value) {
                          print('post Completed');
                        });
                      },
                      child: Text('post')),
                ],
              );
            },
          );
        },
        child: Text('Add'),
      ),
      body: GetBuilder<UserController>(
        init: userController,
        builder: (logic) {
          return FutureBuilder(
            future: logic.fetchRegisterUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                );
              }

              var userData = snapshot.data ?? [];

              return userData.isNotEmpty
                  ? ListView.builder(
                      itemCount: userData.length,
                      itemBuilder: (context, index) {
                        var data = userData[index];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Get.to(
                                  ScreenPostByUser(userId: data.id.toString()));
                            },
                            title: Text('${data.name}'),
                            subtitle: Text('${data.email}'),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text('No Data'),
                    );
            },
          );
        },
      ),
    );
  }
}
