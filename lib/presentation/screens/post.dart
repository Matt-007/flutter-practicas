import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> registerClient({
  required String token,
  required String tipo,
  required String nombreNegocio,
  required String nombreContacto,
  required String telefono,
  required String ciudad,
  required String direccion,
}) async {
  final url = Uri.parse('https://aibootbackend.sistemaagil.net/api/bpartner/');

  final Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> body = {
    'tipo': tipo,
    'nombreNegocio': nombreNegocio,
    'nombreContacto': nombreContacto,
    'telefono': telefono,
    'ciudad': ciudad,
    'direccion': direccion,
  };

  try {
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Cliente registrado exitosamente');
    } else {
      final errorMessage =
          'Error al registrar el cliente: ${response.statusCode}';
      print(errorMessage);
      throw Exception(errorMessage);
    }
  } catch (e) {
    final errorMessage = 'Error: $e';
    print(errorMessage);
    throw Exception(errorMessage);
}
}