import 'package:flutter/material.dart';
import 'package:hola_mundo/widgets/side_menu.dart';

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
      body: body(),
    );
  }

  Widget body() {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(children: []),
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
