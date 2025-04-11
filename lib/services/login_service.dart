import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class LoginService {
  static const String _baseUrl = "https://carros-electricos.wiremockapi.cloud";

  // Método para iniciar sesión
  static Future<bool> login(String username, String password) async {
    return username == "admin";
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
