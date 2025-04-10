import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'AI COVID Scan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Get.offAllNamed(Routes.PATIENT_LIST);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Patients'),
            onTap: () {
              Get.offAllNamed(Routes.PATIENT_LIST);
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('New Scan'),
            onTap: () {
              Get.toNamed(Routes.PATIENT_FORM);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Get.offAllNamed(Routes.LOGIN);
            },
          ),
        ],
      ),
    );
  }
}
