import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_mundo/view_models/contador_view_model.dart';
import 'package:hola_mundo/widgets/side_menu.dart';
import 'package:provider/provider.dart';

class ContadorProvidersPage extends StatelessWidget {
  const ContadorProvidersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ContadorProvider contadorViewModel = context.read<ContadorProvider>();
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
              heroTag: "1",
              child: Icon(Icons.add),
              onPressed: () {
                contadorViewModel.sumar();
              }),
          FloatingActionButton(
              heroTag: "2",
              child: Icon(Icons.remove),
              onPressed: () {
                contadorViewModel.restar();
              })
        ],
      ),
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text(
          "Contador provider",
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Consumer<ContadorProvider>(builder: (context, item, child) {
              return Text(item.contador.toString(),
                  style: TextStyle(fontSize: 30));
            }),
          ]),
        ),
      ),
    );
  }
}
