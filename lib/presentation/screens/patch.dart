import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> updateClient({
  required String token,
  required int clientId,
  required String tipo,
  required String nombreNegocio,
  required String nombreContacto,
  required String telefono,
  required String ciudad,
  required String direccion,
}) async {
  final url = Uri.parse(
      'https://aibootbackend.sistemaagil.net/api/bpartner/$clientId/');

  final Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> body = {
    'tipo': tipo,
    'name': nombreNegocio,
    'contacts': [
      {
        'name': nombreContacto,
        'phone': telefono,
      },
    ],
    'bplocation': [
      {
        'name': ciudad,
        'location': {
          'address1': direccion,
        },
      },
    ],
  };

  try {
    final response =
        await http.patch(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print('Cliente actualizado exitosamente');
    } else {
      final errorMessage =
          'Error al actualizar el cliente: ${response.statusCode}\n${response.body}';
      print(errorMessage);
      throw Exception(errorMessage);
    }
  } catch (e) {
    final errorMessage = 'Error: $e';
    print(errorMessage);
    throw Exception(errorMessage);
  }
}
