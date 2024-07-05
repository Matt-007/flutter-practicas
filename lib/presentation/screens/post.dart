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

  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  Map<String, dynamic> body = {
    'tipo': tipo,
    'nombreNegocio': nombreNegocio,
    'nombreContacto': nombreContacto,
    'telefono': telefono,
    'ciudad': ciudad,
    'direccion': direccion,
    // Puedes agregar más campos según sea necesario para el registro de clientes
  };

  try {
    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      // Cliente registrado exitosamente
      print('Cliente registrado exitosamente');
    } else {
      // Error al registrar el cliente
      print('Error al registrar el cliente: ${response.statusCode}');
      throw Exception('Error al registrar el cliente');
    }
  } catch (e) {
    // Error general
    print('Error: $e');
    throw Exception('Error: $e');
  }
}
