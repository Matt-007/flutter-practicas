import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importar esto para usar LengthLimitingTextInputFormatter
import 'package:http/http.dart' as http;

class ActualizarClientesScreen extends StatefulWidget {
  final String token;
  final int clientId;

  ActualizarClientesScreen({required this.token, required this.clientId});

  @override
  _ActualizarClientesScreenState createState() =>
      _ActualizarClientesScreenState();
}

class _ActualizarClientesScreenState extends State<ActualizarClientesScreen> {
  final List<String> tipoOptions = ['Option 1', 'Option 2'];
  final List<String> ciudadOptions = ['Quito', 'Guayaquil'];

  String _selectedTipo = 'Option 1';
  String _selectedCiudad = 'Quito';

  TextEditingController _nombreNegocioController = TextEditingController();
  TextEditingController _nombreContactoController = TextEditingController();
  TextEditingController _telefonoController = TextEditingController();
  TextEditingController _direccionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchClientData(widget.clientId);
  }

  Future<void> _fetchClientData(int clientId) async {
    final url = Uri.parse(
        'https://aibootbackend.sistemaagil.net/api/bpartner/$clientId/');

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
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cliente no encontrado (Error 404)')),
        );
      } else {
        print('Error al obtener los datos del cliente: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Error al obtener los datos del cliente: ${response.statusCode}')),
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
    if (_telefonoController.text.length < 9 ||
        _telefonoController.text.length > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('El número de teléfono debe tener entre 9 y 10 dígitos')),
      );
      return;
    }

    final url = Uri.parse(
        'https://aibootbackend.sistemaagil.net/api/bpartner/${widget.clientId}/');

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${widget.token}',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      'value': '01',
      'name': _nombreNegocioController.text,
      'tenant': 1000000,
      'org': 1000000,
      'createdby': 100,
      'updatedby': 100,
      'bpgroup': {'id': 103},
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
        print('Cliente actualizado exitosamente');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cliente actualizado exitosamente')),
        );
      } else {
        final errorMessage =
            'Error al actualizar el cliente: ${response.statusCode}\n${response.body}';
        print(errorMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      final errorMessage = 'Error: $e';
      print(errorMessage);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    int? maxLength,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: [
          if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
        ],
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
                  _selectedTipo = value ?? _selectedTipo;
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
              maxLength: 10,
              keyboardType: TextInputType.phone,
            ),
            _buildDropdownField(
              value: _selectedCiudad,
              labelText: 'Ciudad',
              hintText: 'Seleccione la ciudad',
              options: ciudadOptions,
              onChanged: (value) {
                setState(() {
                  _selectedCiudad = value ?? _selectedCiudad;
                });
              },
            ),
            _buildTextField(
              controller: _direccionController,
              labelText: 'Dirección',
              hintText: 'Ej: Calle 123',
            ),
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
