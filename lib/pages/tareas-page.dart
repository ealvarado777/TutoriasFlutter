import 'package:flutter/material.dart';
import 'package:hola_mundo/alerts/alerta.dart';
import 'package:hola_mundo/widgets/side_menu.dart';
import 'package:form_controller/form_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TareasPage extends StatefulWidget {
  const TareasPage({super.key});

  @override
  State<TareasPage> createState() => _TareasPageState();
}

class _TareasPageState extends State<TareasPage> {
  late FormController _formController;
  List<String> tareas = [];

  @override
  void initState() {
    super.initState();
    _formController = FormController(controllers: {'tarea': true});
    //_formController.controller("tarea").text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          child: Icon(Icons.add),
          onPressed: () async {
            dynamic result = await ShowAlerta.showAlerta(
                context: context,
                formController: _formController,
                mensaje: "Hola Mundo",
                titulo: "AÑADIR TAREA");

            if (result.runtimeType == bool) {
              return;
            }

            tareas.add(result);
            setState(() {});
          }),
      appBar: AppBar(
        title: const Text("TAREAS"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: tareas.length,
          itemBuilder: (context, index) {
            String tareaIndex = tareas[index];
            return Slidable(
              key: const ValueKey(0),
              /*  startActionPane: ActionPane(
                motion: ScrollMotion(),
                //dismissible:DismissiblePane(onDismissed: () {}),
                children: [
                  /* SlidableAction(
                    onPressed: (a) {},
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed:null,
                    backgroundColor:Color(0xFF21B7CA),
                    foregroundColor:Colors.white,
                    icon:Icons.share,
                    label:'Share',
                  ),*/
                ],
              ),*/
              //The end action pane is the one at the right or the bottom side.
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (a) {},
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    //label:'Eliminar',
                  ),
                  SlidableAction(
                    onPressed: (_) => {},
                    backgroundColor: const Color(0xFF0392CF),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    //label: 'Editar',
                  ),
                ],
              ),

              // The child of the Slidable is what the user sees when the
              // component is not dragged.
              child: Column(
                children: [
                  ListTile(
                    leading: Image.asset("assets/images/TareaPNG.png"),
                    title: Text(tareaIndex),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 2,
                  )
                ],
              ),
            );
          },
        ),
      )),
    );
  }
}
