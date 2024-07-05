import 'package:flutter/material.dart';
import 'presentation/screens/registro_clientes_screen.dart'; // Importa el archivo correcto de RegistroClientesScreen

void main() {
  String token =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkZXNhcnJvbGxvIiwidGVuYW50aWQiOiIxMSIsImV4cCI6MTcyMDE2MzI5MSwidXNlcmlkIjoiMTAwMDA3MiIsInJvbCI6IkdhcmRlbldvcmxkIEFkbWluIn0.lGWbREum03rKflZNym0a-MmxOitykB_uaNkg6HG5wFXGINHwBOzG0l5ND0C4octrT_v8kDKfDmlNwVp171FEbw';

  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String token;

  MyApp({required this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistroClientesScreen(token: token),
    );
  }
}
