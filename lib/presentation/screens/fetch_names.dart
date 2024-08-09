import 'dart:convert';
import 'package:http/http.dart' as http;

/// Fetches a list of names from the API.
Future<List<Map<String, dynamic>>> fetchNames(String token) async {
  final uri = Uri.parse('https://aibootbackend.sistemaagil.net/api/bpartner/');
  final headers = {'Authorization': 'Bearer $token'};

  final response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) {
      return {
        'id': item['id'],
        'name': item['name'],
      };
    }).toList();
  } else {
    throw Exception('Failed to load names: ${response.statusCode}');
  }
}

/// Deletes a client by ID.
Future<void> deleteCliente(String token, int id) async {
  final uri =
      Uri.parse('https://aibootbackend.sistemaagil.net/api/bpartner/$id');
  final headers = {'Authorization': 'Bearer $token'};

  final response = await http.delete(uri, headers: headers);

  if (response.statusCode != 200) {
    throw Exception('Failed to delete client: ${response.statusCode}');
}
}