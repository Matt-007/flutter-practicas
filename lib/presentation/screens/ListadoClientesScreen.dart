import 'package:flutter/material.dart';
import 'fetch_names.dart'; // Asegúrate de tener la importación correcta

class ListadoClientesScreen extends StatefulWidget {
  ListadoClientesScreen({required this.token});

  final String token;

  @override
  _ListadoClientesScreenState createState() => _ListadoClientesScreenState();
}

class _ListadoClientesScreenState extends State<ListadoClientesScreen> {
  late Future<List<String>> futureNames;

  @override
  void initState() {
    super.initState();
    futureNames = fetchNames(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clientes'),
      ),
      body: Center(
        child: FutureBuilder<List<String>>(
          future: futureNames,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No se encontraron nombres');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}