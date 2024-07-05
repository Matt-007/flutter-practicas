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
    // Puedes agregar más campos según sea necesario para la actualización de clientes
  };

  try {
    final response =
        await http.patch(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      // Cliente actualizado exitosamente
      print('Cliente actualizado exitosamente');
    } else {
      // Error al actualizar el cliente
      print('Error al actualizar el cliente: ${response.statusCode}');
      throw Exception('Error al actualizar el cliente: ${response.statusCode}');
    }
  } catch (e) {
    // Error general
    print('Error: $e');
    throw Exception('Error: $e');
  }
}
