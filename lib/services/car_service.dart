import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/services/login_service.dart';

class CarService {
  static const String _baseUrl = "https://carros-electricos.wiremockapi.cloud";

  static Future<List<dynamic>> getCars() async {

    String token = await LoginService.getToken() ?? '';

    final response = await http.get(
      Uri.parse("$_baseUrl/carros"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> cars = jsonDecode(response.body);
      return cars;
    }
    return [];
  }
}
