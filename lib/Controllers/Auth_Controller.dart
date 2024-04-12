import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Future<String> signUp(String email, String password) async {
    String response = '';
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      response = "Success";
    }).catchError((e) {
      response = '$e';
    });
    return response;
  }

  Future<String> logIn(String email, String password) async {
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
