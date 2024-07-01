import 'package:flutter/material.dart';
import 'package:hello_world_app/presentation/screens/EditarClienteScreen.dart';
import 'cliente.dart';


class ListadoClientes extends StatefulWidget {
  final List<Cliente> clientes;

  const ListadoClientes({
    Key? key,
    required this.clientes,
  }) : super(key: key);

  @override
  _ListadoClientesState createState() => _ListadoClientesState();
}

class _ListadoClientesState extends State<ListadoClientes> {
  late List<Cliente> _clientes;

  @override
  void initState() {
    super.initState();
    _clientes = widget.clientes;
  }

  void _eliminarCliente(int index) {
    setState(() {
      _clientes.removeAt(index);
    });
  }

  void _editarCliente(Cliente clienteActualizado, int index) {
    setState(() {
      _clientes[index] = clienteActualizado;
    });
  }

  void _navegarYEditarCliente(BuildContext context, int index) async {
    final cliente = _clientes[index];
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditarClienteScreen(
          cliente: cliente,
          onSave: (clienteActualizado) {
            _editarCliente(clienteActualizado, index);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _clientes.length,
        itemBuilder: (context, index) {
          final cliente = _clientes[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cliente.tipo,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cliente.nombreNegocio,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Contacto: ${cliente.nombreContacto}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Teléfono: ${cliente.telefono}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ciudad: ${cliente.ciudad}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Dirección: ${cliente.direccion}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _navegarYEditarCliente(context, index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _eliminarCliente(index);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
