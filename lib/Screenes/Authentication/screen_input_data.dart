import 'package:batch_05_firebase/Controllers/Authentication_Controller/MyAuthController.dart';
import 'package:batch_05_firebase/Custom_Widgets/My_Custom_Widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenInputData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(VerficationController());
    var inputName = TextEditingController();
    var inputEmail = TextEditingController();
    var inputPassword = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                showSnakeBar(context, 'Log Out');
              });
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyTextFormField(
              hintText: 'Full name',
              controllerTextField: inputName,
            ),
            MyTextFormField(
              hintText: 'Email Here',
              controllerTextField: inputEmail,
            ),
            MyTextFormField(
              hintText: 'Password Here',
              controllerTextField: inputPassword,
            ),
            GestureDetector(
              onTap: () async {
                var response = await controller.signUp(
                    inputEmail.text, inputPassword.text, inputName.text);
                showSnakeBar(context, response);
              },
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.brown,
                ),
                child: Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                var response =
                    await controller.LogIn(inputEmail.text, inputPassword.text);
                showSnakeBar(context, response);
              },
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.brown,
                ),
                child: Center(
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                var user = await FirebaseAuth.instance.currentUser;
                var response =
                    user == null ? 'Not Log In' : 'Log in with ${user.email}';
                showSnakeBar(context, response);
              },
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.brown,
                ),
                child: Center(
                  child: Text(
                    'Check Log In User',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnakeBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ),
        content: Text(message),
      ),
    );
  }
}
