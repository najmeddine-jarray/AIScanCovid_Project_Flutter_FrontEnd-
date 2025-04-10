import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/welcome_controller.dart';
import '../../routes/app_pages.dart';

class WelcomeView extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('AI COVID Scan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Get.toNamed(Routes.login),
            child: Text('Login'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
          ),
          SizedBox(height: 20),
          OutlinedButton(
            onPressed: () => Get.toNamed(Routes.SIGNUP),
            child: Text('Sign Up'),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
          ),
        ],
      )),
    );
  }
}
