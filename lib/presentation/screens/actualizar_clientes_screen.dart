import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ActualizarClientesScreen extends StatefulWidget {
  final String token;
  final int clientId; // ID del cliente a actualizar

  ActualizarClientesScreen({required this.token, required this.clientId});

  @override
  _ActualizarClientesScreenState createState() =>
      _ActualizarClientesScreenState();
}

class _ActualizarClientesScreenState extends State<ActualizarClientesScreen> {
  // Variables para las opciones del dropdown
  final List<String> tipoOptions = ['Option 1', 'Option 2'];
  final List<String> ciudadOptions = ['Quito', 'Guayaquil'];

  // Variables para mantener el estado de las selecciones del dropdown
  String _selectedTipo = 'Option 1';
  String _selectedCiudad = 'Quito';

  // Inicializando los controladores de texto
  TextEditingController _nombreNegocioController = TextEditingController();
  TextEditingController _nombreContactoController = TextEditingController();
  TextEditingController _telefonoController = TextEditingController();
  TextEditingController _direccionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchClientData();
  }

  Future<void> _fetchClientData() async {
    final url = Uri.parse(
        'https://aibootbackend.sistemaagil.net/api/bpartner/${widget.clientId}');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _nombreNegocioController.text = data['name'];
          _nombreContactoController.text = data['contacts'][0]['name'];
          _telefonoController.text = data['contacts'][0]['phone'];
          _direccionController.text =
              data['bplocation'][0]['location']['address1'];
          _selectedCiudad = data['bplocation'][0]['name'];
        });
      } else {
        print('Error al obtener los datos del cliente: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Error al obtener los datos del cliente: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _actualizarCliente() async {
    final url = Uri.parse(
        'https://aibootbackend.sistemaagil.net/api/bpartner/${widget.clientId}');

    Map<String, String> headers = {
      'Authorization': 'Bearer ${widget.token}',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'value': '01', // Ejemplo de valor, ajusta según sea necesario
      'name': _nombreNegocioController.text,
      'tenant': 1000000,
      'org': 1000000,
      'createdby': 100,
      'updatedby': 100,
      'bpgroup': {'id': 1000013},
      'bplocation': [
        {
          'tenant': 1000000,
          'org': 1000000,
          'createdby': 100,
          'updatedby': 100,
          'name': _selectedCiudad,
          'location': {
            'address1': _direccionController.text,
          },
        },
      ],
      'contacts': [
        {
          'name': _nombreContactoController.text,
          'phone': _telefonoController.text,
        },
      ],
    };

    try {
      final response = await http.patch(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Cliente actualizado exitosamente
        print('Cliente actualizado exitosamente');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cliente actualizado exitosamente')),
        );
      } else {
        // Error al actualizar el cliente
        print('Error al actualizar el cliente: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Error al actualizar el cliente: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      // Error general
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.blue.shade50,
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required String labelText,
    required String hintText,
    required List<String> options,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.blue.shade50,
        ),
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Actualizar Cliente',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            _buildDropdownField(
              value: _selectedTipo,
              labelText: 'Tipo',
              hintText: 'Option 1',
              options: tipoOptions,
              onChanged: (value) {
                setState(() {
                  _selectedTipo = value!;
                });
              },
            ),
            _buildTextField(
              controller: _nombreNegocioController,
              labelText: 'Nombre del negocio',
              hintText: 'Ej: Inversiones XYZ',
            ),
            _buildTextField(
              controller: _nombreContactoController,
              labelText: 'Nombre de contacto',
              hintText: 'Ej: Maria',
            ),
            _buildTextField(
              controller: _telefonoController,
              labelText: 'Teléfono',
              hintText: 'Ej: 04125555555',
            ),
            _buildDropdownField(
              value: _selectedCiudad,
              labelText: 'Ciudad',
              hintText: 'Quito',
              options: ciudadOptions,
              onChanged: (value) {
                setState(() {
                  _selectedCiudad = value!;
                });
              },
            ),
            _buildTextField(
              controller: _direccionController,
              labelText: 'Dirección',
              hintText: 'Ej: Carrera x calle 2',
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _actualizarCliente,
              child: Text('Actualizar Cliente'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
