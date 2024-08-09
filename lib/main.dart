import 'package:flutter/material.dart';
import 'presentation/screens/ListadoClientesScreen.dart';

void main() {
  String token =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkZXNhcnJvbGxvIiwidGVuYW50aWQiOiIxMSIsImV4cCI6MTcyMzI3ODUyNiwidXNlcmlkIjoiMTAwMDA3MiIsInJvbCI6IkdhcmRlbldvcmxkIEFkbWluIn0.RFZFCjTp82WYikRKkG12qSJzNcG8RPyWees2CQe9adtNDA0og2uD4IXOwdPeTxNmhZhWQvEnVccxDjnrbqTBJw';

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