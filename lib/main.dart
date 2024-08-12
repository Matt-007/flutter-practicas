import 'package:flutter/material.dart';
import 'presentation/screens/ListadoClientesScreen.dart';

void main() {
  String token =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkZXNhcnJvbGxvIiwidGVuYW50aWQiOiIxMSIsImV4cCI6MTcyMzQ1OTQzNywidXNlcmlkIjoiMTAwMDA3MiIsInJvbCI6IkdhcmRlbldvcmxkIEFkbWluIn0.N0KtPhoUo7s5Pxdbf2kyDptSaHnmhnmJHj89angWDC8tWjeg-svuETGnKZJJsh_oOPYCIy25nIPx-4A86xSgyA';

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
