// // main.dart

// import 'package:flutter/material.dart';
// import './presentation/screens/home_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
//       home: const HomeScreen(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'presentation/screens/ListadoClientesScreen.dart'; // Asegúrate de tener la importación correcta

void main() {
  String token ='eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkZXNhcnJvbGxvIiwidGVuYW50aWQiOiIxMSIsImV4cCI6MTcyMDIyMjU5NiwidXNlcmlkIjoiMTAwMDA3MiIsInJvbCI6IkdhcmRlbldvcmxkIEFkbWluIn0.0nYQJRmUrLkRrQgwNNFZz7VWcra_7LxgRJSEukUBxDL6nhMvxOsFGNDDnntdZNXsX6Q3ZQpUJslBgNgHx0m8DQ';

  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String token;

  MyApp({required this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListadoClientesScreen(token: token),
    );
  }
}
