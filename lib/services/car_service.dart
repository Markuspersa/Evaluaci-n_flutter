import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarService {
  static const String _baseUrl = "https://carros-electricos.wiremockapi.cloud";
  static const String _mockApiUrl = "https://67f7d1812466325443eadd17.mockapi.io";

  static Future<List<dynamic>> getCars() async {
    final prefs = await SharedPreferences.getInstance();
    final data = await prefs.getString("carros");
    if (data != null) {
      final decodedData = jsonDecode(data) as List<dynamic>;
      return decodedData.map((item) {
        return Map<String, String>.from(item.map((key, value) => 
          MapEntry(key.toString(), value.toString())));
      }).toList();
    }
    return [];
  }
  

  
  static Future<Map<String, dynamic>?> getCarById(String id) async {
    final response = await http.get(
      Uri.parse("$_mockApiUrl/carros/$id"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null; 
  }

  static Future<List<dynamic>> getAllCarsFromMockAPI() async {
  final response = await http.get(
    Uri.parse("https://67f7d1812466325443eadd17.mockapi.io/carros"),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Error al obtener carros');
  }
}


}

