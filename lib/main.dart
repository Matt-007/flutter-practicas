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
  String token =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkZXNhcnJvbGxvIiwidGVuYW50aWQiOiIxMSIsImV4cCI6MTcyMDA4NzAwNCwidXNlcmlkIjoiMTAwMDA3MiIsInJvbCI6IkdhcmRlbldvcmxkIEFkbWluIn0.wM1T2HPUFEKwEtm1ApJpU6t8zzVEjbIgyrZgRjVmKU0o4omOefBMkkLQgwMOHW0R5sLgw-z8KvD9j1N-zy6lfg';

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
