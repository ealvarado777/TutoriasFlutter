import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hola_mundo/view_models/cliente_view_model.dart';
import 'package:hola_mundo/widgets/side_menu.dart';
import 'package:provider/provider.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({super.key});

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  bool _isSearching = false;
  final TextEditingController _searchQueryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      iniciar();
    });
  }

  void iniciar() {
    ClienteViewModel clienteViewModel = ClienteViewModel();
    clienteViewModel.iniciar(contextA: context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: _isSearching ? _buildSearchField() : const Text('Clientes'),
        actions: _buildActions(),
      ),
      body: body(size),
    );
  }

  Widget body(Size size) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(children: [
        Consumer<ClienteViewModel>(builder: (context, item, child) {
          return ListView.builder(
            itemCount: item.clientes.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> cliente = item.clientes[index];

              return ListTile(
                title: Text(cliente["nombres"]),
              );
            },
          );
        })
      ]),
    ));
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return [
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _searchQueryController.clear();
            });
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
      ];
    }
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Buscar...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white54),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
    );
  }
}
