import 'package:batch_05_firebase/Modal/User_Modal_Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerficationController extends GetxController {
  Future<String> signUp(String email, String password, String name) async {
    String response = '';
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await value.user?.updateDisplayName(name);
      var obj = UserModal(
          name: name, email: email, password: password, id: value.user!.uid);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(obj.id)
          .set(obj.toMap());
      response = 'Success';
    }).catchError((e) {
      response = '$e';
    });
    return response;
  }

  Future<String> LogIn(String email, String password) async {
    String response = '';
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      response = 'Success';
    }).catchError((e) {
      response = '$e';
    });
    return response;
  }
}
