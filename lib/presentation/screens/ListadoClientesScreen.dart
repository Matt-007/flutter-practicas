import 'package:flutter/material.dart';
import 'fetch_names.dart';

class ListadoClientesScreen extends StatefulWidget {
  final String token;

  ListadoClientesScreen({required this.token});

  @override
  _ListadoClientesScreenState createState() => _ListadoClientesScreenState();
}

class _ListadoClientesScreenState extends State<ListadoClientesScreen> {
  late Future<List<Map<String, dynamic>>> futureClientes;
  List<Map<String, dynamic>> allClientes = [];
  List<Map<String, dynamic>> filteredClientes = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureClientes = fetchNames(widget.token);
    futureClientes.then((clientes) {
      setState(() {
        allClientes = clientes;
        filteredClientes = clientes;
      });
    });
    searchController.addListener(_filterClientes);
  }

  void _filterClientes() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredClientes = allClientes.where((cliente) {
        final name = cliente['name'].toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  Future<void> deleteClienteFromList(int index) async {
    try {
      final id = filteredClientes[index]['id'];
      await deleteCliente(widget.token, id);
      setState(() {
        allClientes.removeWhere((cliente) => cliente['id'] == id);
        filteredClientes.removeAt(index);
      });
    } catch (e) {
      print('Error deleting client: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error eliminando cliente: $e'),
        ),
      );
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clientes', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 110, 110, 110),
      ),
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Buscar...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: futureClientes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.red));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No se encontraron nombres');
                  } else {
                    return ListView.builder(
                      itemCount: filteredClientes.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(filteredClientes[index]['id'].toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            deleteClienteFromList(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Cliente eliminado'),
                              ),
                            );
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 0),
                            elevation: 2,
                            child: ListTile(
                              leading: Icon(Icons.person,
                                  color: Color.fromARGB(255, 102, 195, 231)),
                              title: Text(filteredClientes[index]['name'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Colors.grey),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
