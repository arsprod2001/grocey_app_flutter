import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://10.7.143.57:3005/api';

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone': phone,
          'address': address,
          'password': password,
        }),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': responseBody['message'],
          'user': responseBody['user'],
        };
      } else {
        return {
          'success': false,
          'message': responseBody['error'] ?? 'Erreur d\'inscription',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur de connexion au serveur: ${e.toString()}',
      };
    }
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseBody['message'],
          'user': responseBody['user'],
        };
      } else {
        return {
          'success': false,
          'message': responseBody['error'] ?? 'Erreur de connexion',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur de connexion au serveur: ${e.toString()}',
      };
    }
  }

  static Future<Map<String, dynamic>> checkEmailExists(String email) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/check-email/$email'),
        headers: {'Accept': 'application/json'},
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'exists': responseBody['exists'] ?? false};
      } else {
        return {
          'success': false,
          'exists': false,
          'message': responseBody['error'] ?? 'Erreur de vérification',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'exists': false,
        'message': 'Erreur de connexion: ${e.toString()}',
      };
    }
  }
}
