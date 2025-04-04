import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static const String _baseUrl = "https://carros-electricos.wiremockapi.cloud";

  // Método para iniciar sesión
  static Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/auth"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token']; // Asegúrate de que el JSON de respuesta contiene un campo 'token'
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token); // Guardamos el token localmente

      return true; // Login exitoso
    }
    return false; // Error en login
  }

  // Método para cerrar sesión
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Eliminamos el token almacenado
  }

  // Método para obtener el token guardado
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
