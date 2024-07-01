import 'package:flutter/material.dart';
import 'registro_clientes_screen.dart';
import 'listado_clientes.dart';
import 'cliente.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Cliente> _clientes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro y Listado de Clientes'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RegistroClientesScreen(
            onClienteSaved: _agregarCliente, // Pasa la función _agregarCliente
          ),
          const SizedBox(height: 20),
          ListadoClientes(clientes: _clientes),
        ],
      ),
    );
  }

  void _agregarCliente(Cliente cliente) {
    setState(() {
      _clientes.add(cliente);
    });
    print('Cliente guardado: $cliente');
  }
}
