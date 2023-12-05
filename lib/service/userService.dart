import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pdv_project_teste_1/Models/User.dart';

class UserService {
  static const API_KEY = "AIzaSyABVmCsTYjbJtmGor4yJDf3h80TafevuZ0";

  Future<User?> userLogin(String email, String senha) async {
    Uri url = Uri.parse(
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${API_KEY}",
    );

    final Map<String, dynamic> data = {
      'email': email,
      'password': senha,
      "returnSecureToken": true,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return User(email: json['email'], senha: senha, token: json['idToken']);
    } else {
      return null;
    }
  }
}
