import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/patient_controller.dart';
import '../../routes/app_pages.dart';

class PatientListView extends GetView<PatientController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patients List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              controller.fetchPatients();
            },
          ),
        ],
      ),

      // 🔽 FAB added here
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(Routes.PATIENT_FORM);
        },
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text(
          "Add Patient",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.patients.isEmpty) {
          return Center(
            child: Text(
              'No patients found.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchPatients,
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.patients.length,
            itemBuilder: (context, index) {
              final reversedPatients = controller.patients.reversed.toList();
              final patient = reversedPatients[index];
              final initials =
                  (patient.firstname.isNotEmpty ? patient.firstname[0] : '') +
                      (patient.lastname.isNotEmpty ? patient.lastname[0] : '');

              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    _showPatientDetailsDialog(context, patient);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.blueAccent[400],
                          child: Text(
                            initials.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${patient.firstname} ${patient.lastname}',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.analytics,
                                      size: 16, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Result: ${patient.result}',
                                    style: TextStyle(
                                      color: patient.result.toLowerCase() ==
                                              'normal'
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  void _showPatientDetailsDialog(BuildContext context, patient) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      "${patient.firstname[0].toUpperCase()}${patient.lastname[0].toUpperCase()}",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '${patient.firstname} ${patient.lastname}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 20),
                  _infoTile(Icons.phone, "Phone Number", patient.phonenumber),
                  _infoTile(Icons.credit_card, "CIN", patient.cin),
                  _infoTile(Icons.cake, "Birth Date", patient.birth),
                  _infoTile(
                    Icons.health_and_safety,
                    "Result",
                    patient.result,
                    valueColor:
                        patient.result == 'Normal' ? Colors.green : Colors.red,
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: Icon(Icons.close),
                      label: Text("Close"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _infoTile(IconData icon, String label, String value,
      {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    color: valueColor ?? Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
