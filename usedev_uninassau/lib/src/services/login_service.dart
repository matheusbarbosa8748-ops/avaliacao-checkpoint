import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static const String _baseUrl = 'https://fakestoreapi.com/auth/login';
  static const String _tokenKey = 'auth_token';
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  /// Realiza o login na API e armazena o token em armazenamento seguro.
  static Future<String> login({
    required String username,
    required String password,
  }) async {
    final uri = Uri.parse(_baseUrl);
    final body = jsonEncode({'username': username, 'password': password});

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode < 300) {
      final bodyJson = jsonDecode(response.body) as Map<String, dynamic>;
      final token = bodyJson['token'] as String?;
      if (token == null || token.isEmpty) {
        throw Exception('Resposta de login inválida: token não encontrado.');
      }

      await _secureStorage.write(key: _tokenKey, value: token);
      return token;
    }

    throw Exception(
      'Falha no login. Verifique usuário e senha. Código: ${response.statusCode}',
    );
  }

  /// Recupera o token armazenado, se houver.
  static Future<String?> getToken() async {
    return _secureStorage.read(key: _tokenKey);
  }

  /// Retorna true se o usuário já está logado.
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Limpa o token armazenado.
  static Future<void> logout() async {
    await _secureStorage.delete(key: _tokenKey);
  }
}
