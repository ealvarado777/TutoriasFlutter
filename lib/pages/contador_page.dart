import 'package:flutter/material.dart';
import 'package:hola_mundo/widgets/side_menu.dart';

class ContadorPage extends StatefulWidget {
  const ContadorPage({super.key});

  @override
  State<ContadorPage> createState() => _ContadorPageState();
}

class _ContadorPageState extends State<ContadorPage> {
  int contador = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
              heroTag: "1",
              child: Icon(Icons.add),
              onPressed: () {
                contador++;
                setState(() {});
              }),
          FloatingActionButton(
              heroTag: "2",
              child: Icon(Icons.remove),
              onPressed: () {
                contador--;
                setState(() {});
              })
        ],
      ),
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text(
          "Contador",
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(contador.toString(), style: TextStyle(fontSize: 30))
          ]),
        ),
      ),
    );
  }
}
