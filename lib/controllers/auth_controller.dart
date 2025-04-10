import 'package:get/get.dart';
import '../services/api_service.dart';
import '../routes/app_pages.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading(true);
      final response = await ApiService.login(email, password);

      if (response.statusCode == 200) {
        Get.offAllNamed(Routes.patientList);
        Get.snackbar('Success', 'Login successful');
      } else {
        Get.snackbar('Error', 'Invalid credentials');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      isLoading(true);
      final response = await ApiService.signup(email, password);

      if (response.statusCode == 201) {
        Get.offNamed(Routes.login);
        Get.snackbar('Success', 'Account created successfully');
      } else {
        final error = response.body;
        Get.snackbar(
            'Error',
            error.contains('exists')
                ? 'Email already exists'
                : 'Registration failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
