import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'actualizar_clientes_screen.dart';

class RegistroClientesScreen extends StatefulWidget {
  final String token;

  const RegistroClientesScreen({required this.token, Key? key})
      : super(key: key);

  @override
  _RegistroClientesScreenState createState() => _RegistroClientesScreenState();
}

class _RegistroClientesScreenState extends State<RegistroClientesScreen> {
  // Opciones del dropdown
  final List<String> tipoOptions = ['Option 1', 'Option 2'];
  final List<String> ciudadOptions = ['Quito', 'Guayaquil'];

  // Estado de las selecciones del dropdown
  String _selectedTipo = 'Option 1';
  String _selectedCiudad = 'Quito';

  // Controladores de texto
  final TextEditingController _nombreNegocioController =
      TextEditingController();
  final TextEditingController _nombreContactoController =
      TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();

  Future<void> _guardarCliente() async {
    final url =
        Uri.parse('https://aibootbackend.sistemaagil.net/api/bpartner/');

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
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cliente registrado exitosamente')),
        );
        // Limpiar campos después de registrar el cliente
        _limpiarCampos();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Error al registrar el cliente: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _limpiarCampos() {
    _nombreNegocioController.clear();
    _nombreContactoController.clear();
    _telefonoController.clear();
    _direccionController.clear();
    setState(() {
      _selectedTipo = tipoOptions.first;
      _selectedCiudad = ciudadOptions.first;
    });
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
    required ValueChanged<String?> onChanged,
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
        title: const Text('Clientes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActualizarClientesScreen(
                  token: widget.token,
                  clientId: 123,
                ),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Registro de clientes',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
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
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _guardarCliente,
              child: const Text('Guardar Cliente'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                textStyle: const TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
),
);
}
}