import 'package:flutter/material.dart';
import 'package:hola_mundo/widgets/side_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      drawer: SideMenu(),
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Home",
            textAlign: TextAlign.center,
          )),
      body: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(child: Image.asset('assets/images/imagen_grupo_diosmar.png'))
      ])),
    );
  }
}
