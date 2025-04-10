import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/patient_controller.dart';
import '../../routes/app_pages.dart';

class PatientListView extends GetView<PatientController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed(Routes.PATIENT_FORM);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.patients.length,
          itemBuilder: (context, index) {
            final patient = controller.patients[index];
            return ListTile(
              title: Text('${patient.firstname} ${patient.lastname}'),
              subtitle: Text('Result: ${patient.result}'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to patient details if needed
              },
            );
          },
        );
      }),
    );
  }
}
