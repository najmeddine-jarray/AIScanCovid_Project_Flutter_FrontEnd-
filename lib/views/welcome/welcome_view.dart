import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/welcome_controller.dart';
import '../../routes/app_pages.dart';

class WelcomeView extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F8FA),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.coronavirus, size: 100, color: Colors.blueAccent),
                SizedBox(height: 20),
                Text(
                  'AI COVID Scan',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'AI-powered diagnosis made fast, accurate, and easy.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                ElevatedButton.icon(
                  onPressed: () => Get.toNamed(Routes.login),
                  icon: Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () => Get.toNamed(Routes.signup),
                  icon: Icon(Icons.person_add_alt_1, color: Colors.blueAccent),
                  label: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    side: BorderSide(color: Colors.blueAccent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
