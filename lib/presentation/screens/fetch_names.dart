import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchNames(String token) async {
  final response = await http.get(
    Uri.parse('https://aibootbackend.sistemaagil.net/api/bpartner/'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => {
      'id': item['id'],
      'name': item['name'],
    }).toList();
  } else {
    throw Exception('Failed to load names');
  }
}

Future<void> deleteCliente(String token, int id) async {
  final response = await http.delete(
    Uri.parse('https://aibootbackend.sistemaagil.net/api/bpartner/$id'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to delete cliente');
  }
}
