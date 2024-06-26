import 'package:batch_05_firebase/Modal/User_Modal_Auth.dart';
import 'package:batch_05_firebase/Modal/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

class UserController extends GetxController {
  Future<List<UserModal>> fetchRegisterUser() async {
    //await Future.delayed(Duration(seconds: 3));
    var result = await FirebaseFirestore.instance.collection('users').get();
    var docs = result.docs;
    var users = docs.map((e) => UserModal.fromMap(e.data())).toList();
    GetStoragePro.saveObjectsList(users);
    return users;
  }

  DeleteData() {
    FirebaseFirestore.instance.collection('users').doc().delete();
  }

  Future<void> addPost(PostModal postModal) async {
    await FirebaseFirestore.instance
        .collection('post')
        .doc(postModal.id)
        .set(postModal.toMap());
  }

  // Future<void> addPost(PostModal postModal) async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(postModal.userId)
  //       .collection('posts')
  //       .doc(postModal.id)
  //       .set(postModal.toMap());
  // }
}
