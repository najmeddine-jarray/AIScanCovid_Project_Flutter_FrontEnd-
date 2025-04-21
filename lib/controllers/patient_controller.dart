import 'dart:convert';

import 'package:get/get.dart';
import '../models/patient_model.dart';
import '../services/api_service.dart';

class PatientController extends GetxController {
  var patients = <Patient>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchPatients();
    super.onInit();
  }

  Future<void> fetchPatients() async {
    try {
      isLoading(true);
      final response = await ApiService.getPatients();

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        patients
            .assignAll(jsonData.map((item) => Patient.fromJson(item)).toList());
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch patients: $e');
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
