import 'package:batch_05_firebase/Controllers/Auth_Controller.dart';
import 'package:batch_05_firebase/Extention/Padding_Extention.dart';
import 'package:batch_05_firebase/Screenes/First/custom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenInput extends StatelessWidget {
  const ScreenInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          'Authentication',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Log Out')));
              });
            },
            icon: Icon(Icons.logout),
            color: Colors.white,
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email Here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ).onlyPadding(left: 10, right: 10, top: 60),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password Here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ).onlyPadding(left: 10, right: 10, top: 60),
            GestureDetector(
              onTap: () async {
                var response = await controller.signUp(
                    emailController.text, passwordController.text);
                ScaffoldMessenger.of(Get.context!).showSnackBar(
                  SnackBar(
                    padding: EdgeInsets.all(10),
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      '$response',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                width: ScreenWidth * 0.3,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.brown),
                child: Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
            ).onlyPadding(left: 10, right: 10, top: 60),
            MyContainer(controller: controller, emailController: emailController, passwordController: passwordController, ScreenWidth: ScreenWidth).onlyPadding(left: 10, right: 10, top: 60),
            GestureDetector(
              onTap: () async {
                var user = await FirebaseAuth.instance.currentUser;
                var response = user == null ? 'Not Log In' : '${user.email}';
                showSnackBarDialog(context, response);
                // ScaffoldMessenger.of(Get.context!).showSnackBar(
                //   SnackBar(
                //     padding: EdgeInsets.all(10),
                //     behavior: SnackBarBehavior.floating,
                //     content: Text(
                //       '$response',
                //       style: TextStyle(
                //         fontSize: 12,
                //         fontWeight: FontWeight.w700,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // );
              },
              child: Container(
                width: ScreenWidth * 0.5,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.brown),
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
              ).onlyPadding(left: 10, right: 10, top: 60),
            )
          ],
        ),
      ),
    );
  }

  void showSnackBarDialog(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 10),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            Get.back();
          },
        ),
        content: Text('${message}'),
      ),
    );
  }
}


