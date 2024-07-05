import 'package:flutter/material.dart';
import 'package:hello_world_app/presentation/screens/actualizar_clientes_screen.dart';

class MiPagina extends StatelessWidget {
  final String token;
  final int clientId; // Asegúrate de definir clientId aquí

  MiPagina({required this.token, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Página'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActualizarClientesScreen(
                  token: token,
                  clientId: clientId, // Asegúrate de pasar clientId aquí
                ),
              ),
            );
          },
          child: Text('Ir a Actualizar Clientes'),
        ),
      ),
    );
  }
}
