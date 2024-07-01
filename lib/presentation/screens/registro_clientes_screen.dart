import 'package:flutter/material.dart';
import 'cliente.dart'; // Asegúrate de importar la clase Cliente si no lo has hecho aún

class RegistroClientesScreen extends StatefulWidget {
  final Function(Cliente) onClienteSaved;

  const RegistroClientesScreen({
    Key? key,
    required this.onClienteSaved,
  }) : super(key: key);

  @override
  State<RegistroClientesScreen> createState() => _RegistroClientesScreenState();
}

class _RegistroClientesScreenState extends State<RegistroClientesScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _tipo;
  String _nombreNegocio = '';
  String _nombreContacto = '';
  String _telefono = '';
  String? _ciudad;
  String _direccion = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  _tipo = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Seleccione un tipo' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Nombre del negocio',
                  hintText: 'Ej: Inversiones XYZ'),
              onChanged: (value) {
                setState(() {
                  _nombreNegocio = value;
                });
              },
              validator: (value) =>
                  value!.isEmpty ? 'Ingrese el nombre del negocio' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Nombre de contacto', hintText: 'Ej: Maria'),
              onChanged: (value) {
                setState(() {
                  _nombreContacto = value;
                });
              },
              validator: (value) =>
                  value!.isEmpty ? 'Ingrese el nombre de contacto' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Teléfono', hintText: 'Ej: 04125555555'),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  _telefono = value;
                });
              },
              validator: (value) =>
                  value!.isEmpty ? 'Ingrese el teléfono' : null,
            ),
            DropdownButtonFormField<String>(
              value: _ciudad,
              decoration: const InputDecoration(labelText: 'Ciudad'),
              items: const [
                DropdownMenuItem(value: 'Quito', child: Text('Quito')),
                DropdownMenuItem(
                    value: 'Guayaquil', child: Text('Guayaquil')),
              ],
              onChanged: (value) {
                setState(() {
                  _ciudad = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Seleccione una ciudad' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Dirección', hintText: 'Ej: Carrera x calle 2'),
              onChanged: (value) {
                setState(() {
                  _direccion = value;
                });
              },
              validator: (value) =>
                  value!.isEmpty ? 'Ingrese la dirección' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final nuevoCliente = Cliente(
                    tipo: _tipo!,
                    nombreNegocio: _nombreNegocio,
                    nombreContacto: _nombreContacto,
                    telefono: _telefono,
                    ciudad: _ciudad!,
                    direccion: _direccion,
                  );
                  widget.onClienteSaved(nuevoCliente); // Llama a la función onClienteSaved
                  _resetForm();
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _tipo = null;
      _nombreNegocio = '';
      _nombreContacto = '';
      _telefono = '';
      _ciudad = null;
      _direccion = '';
    });
  }
}
