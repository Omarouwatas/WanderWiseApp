import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wise2/components/globals.dart';

Future<Map<String, dynamic>> fetchUserProfile(String token) async {
  final url = Uri.parse('$baseUrl/profile/');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load profile');
  }
}
