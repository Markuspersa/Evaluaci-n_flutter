import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CarService {
  static const String _mockApiUrl = "https://67f7d1812466325443eadd17.mockapi.io";
  static const String _carsKey = 'cars';

  static Future<List<Map<String, String>>> getCars() async {
    final prefs = await SharedPreferences.getInstance();
    final carsJson = prefs.getStringList(_carsKey) ?? [];
    return carsJson.map((car) {
      return Map<String, String>.from(jsonDecode(car));
    }).toList();
  }

  static Future<void> saveCar(Map<String, dynamic> car) async {
    final prefs = await SharedPreferences.getInstance();
    final cars = await getCars();
    cars.add(car.map((key, value) => MapEntry(key, value.toString())));

    final carsJson = cars.map((carMap) => jsonEncode(carMap)).toList();

    await prefs.setStringList(_carsKey, carsJson);

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

