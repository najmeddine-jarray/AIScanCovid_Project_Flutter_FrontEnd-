import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseUrl = 'http://10.0.2.2:5000';

  static Future<http.Response> signup(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    return response;
  }

  static Future<http.Response> getPatients() async {
    final response = await http.get(
      Uri.parse('$baseUrl/get'),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }

  static Future<http.Response> scanPatient({
    required String firstname,
    required String lastname,
    required String phonenumber,
    required String cin,
    required String birth,
    required String imageBase64,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/scanner'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'firstname': firstname,
        'lastname': lastname,
        'phonenumber': phonenumber,
        'cin': cin,
        'birth': birth,
        'image': imageBase64,
      }),
    );
    return response;
  }
}
