import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/Auth_Controller.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({
    super.key,
    required this.controller,
    required this.emailController,
    required this.passwordController,
    required this.ScreenWidth,
  });

  final AuthController controller;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final double ScreenWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var response = await controller.logIn(
            emailController.text, passwordController.text);
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            padding: EdgeInsets.all(10),
            behavior: SnackBarBehavior.floating,
            content: Text(
              response,
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
            'Log In',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}