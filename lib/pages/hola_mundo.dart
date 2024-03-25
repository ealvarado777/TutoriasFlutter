import 'package:flutter/material.dart';
import 'package:hola_mundo/widgets/side_menu.dart';

class HolamundoPage extends StatefulWidget {
  const HolamundoPage({super.key});

  @override
  State<HolamundoPage> createState() => _HolamundoPageState();
}

class _HolamundoPageState extends State<HolamundoPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        //leading: Icon(Icons.search),
        actions: [Icon(Icons.access_alarms_sharp), Icon(Icons.add)],
        centerTitle: true,
        title: Text("Hola Mundo"),
      ),
      backgroundColor: Color(0xFF202355),
      //backgroundColor:Colors.blue,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "Hola mundo",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ))
          ],
        ),
      ),
    );
  }
}
