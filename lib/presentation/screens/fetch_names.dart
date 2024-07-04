import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchNames(String token) async {
  final response = await http.get(
    Uri.parse('https://aibootbackend.sistemaagil.net/api/bpartner/'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    List<String> names = data.map((item) => item['name'].toString()).toList();
    return names;
  } else {
    throw Exception('Failed to load names');
  }
}