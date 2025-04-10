import 'package:get/get.dart';
import '../controllers/patient_controller.dart';
import '../controllers/welcome_controller.dart';
import '../views/auth/Sign_view.dart';
import '../views/auth/login_view.dart';
import '../views/welcome/welcome_view.dart';
import '../views/patient/patient_list_view.dart';
import '../views/patient/patient_form_view.dart';
import '../controllers/auth_controller.dart';

abstract class AppPages {
  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: Routes.WELCOME,
      page: () => WelcomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => WelcomeController());
      }),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthController());
      }),
    ),
    GetPage(
      name: Routes.SIGNUP, // Add this route
      page: () => SignupView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthController());
      }),
    ),
    GetPage(
      name: Routes.PATIENT_LIST,
      page: () => PatientListView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PatientController());
      }),
    ),
    GetPage(
      name: Routes.PATIENT_FORM,
      page: () => PatientFormView(),
    ),
  ];
}

abstract class Routes {
  static const WELCOME = '/welcome';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup'; // Add this constant
  static const PATIENT_LIST = '/patients';
  static const PATIENT_FORM = '/patient-form';

  static String get welcome => WELCOME;
  static String get login => LOGIN;
  static String get signup => SIGNUP; // Add this getter
  static String get patientList => PATIENT_LIST;
  static String get patientForm => PATIENT_FORM;
}
