import 'package:flutter/material.dart';
import 'cliente.dart';

class EditarClienteScreen extends StatefulWidget {
  final Cliente cliente;
  final Function(Cliente) onSave;

  const EditarClienteScreen({
    Key? key,
    required this.cliente,
    required this.onSave,
  }) : super(key: key);

  @override
  _EditarClienteScreenState createState() => _EditarClienteScreenState();
}

class _EditarClienteScreenState extends State<EditarClienteScreen> {
  late TextEditingController _nombreNegocioController;
  late TextEditingController _nombreContactoController;
  late TextEditingController _telefonoController;
  late TextEditingController _ciudadController;
  late TextEditingController _direccionController;
  late String _tipo;

  @override
  void initState() {
    super.initState();
    _tipo = widget.cliente.tipo;
    _nombreNegocioController = TextEditingController(text: widget.cliente.nombreNegocio);
    _nombreContactoController = TextEditingController(text: widget.cliente.nombreContacto);
    _telefonoController = TextEditingController(text: widget.cliente.telefono);
    _ciudadController = TextEditingController(text: widget.cliente.ciudad);
    _direccionController = TextEditingController(text: widget.cliente.direccion);
  }

  @override
  void dispose() {
    _nombreNegocioController.dispose();
    _nombreContactoController.dispose();
    _telefonoController.dispose();
    _ciudadController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  void _guardarCambios() {
    final actualizado = Cliente(
      tipo: _tipo,
      nombreNegocio: _nombreNegocioController.text,
      nombreContacto: _nombreContactoController.text,
      telefono: _telefonoController.text,
      ciudad: _ciudadController.text,
      direccion: _direccionController.text,
    );
    widget.onSave(actualizado);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _tipo,
              decoration: const InputDecoration(labelText: 'Tipo'),
              items: const [
                DropdownMenuItem(value: 'Option 1', child: Text('Opción 1')),
                DropdownMenuItem(value: 'Option 2', child: Text('Opción 2')),
              ],
              onChanged: (value) {
                setState(() {
                  _tipo = value!;
                });
              },
              validator: (value) => value == null ? 'Seleccione un tipo' : null,
            ),
            TextField(
              controller: _nombreNegocioController,
              decoration: InputDecoration(labelText: 'Nombre del Negocio'),
            ),
            TextField(
              controller: _nombreContactoController,
              decoration: InputDecoration(labelText: 'Nombre del Contacto'),
            ),
            TextField(
              controller: _telefonoController,
              decoration: InputDecoration(labelText: 'Teléfono'),
            ),
            TextField(
              controller: _ciudadController,
              decoration: InputDecoration(labelText: 'Ciudad'),
            ),
            TextField(
              controller: _direccionController,
              decoration: InputDecoration(labelText: 'Dirección'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _guardarCambios,
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
