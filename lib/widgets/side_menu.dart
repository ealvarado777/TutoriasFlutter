import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Container(
            //color: Colors.yellowAccent,
            child: Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/imagen_grupo_diosmar.png')),
          )),
          ListTile(
            trailing: Icon(Icons.keyboard_arrow_right),
            hoverColor: Colors.blue,
            leading: Icon(Icons.content_paste_search_rounded),
            title: Text("Hola Mundo"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("HolaMundo");
            },
          ),
          ListTile(
            trailing: Icon(Icons.keyboard_arrow_right),
            hoverColor: Colors.blue,
            leading: Icon(Icons.content_paste_search_rounded),
            title: Text("HomePage"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("HomePage");
            },
          ),
          ListTile(
            trailing: Icon(Icons.keyboard_arrow_right),
            hoverColor: Colors.blue,
            leading: Icon(Icons.content_paste_search_rounded),
            title: Text("Tareas"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("TareasPage");
            },
          ),
        ],
      ),
    );
  }
}
