import 'package:flutter/material.dart';
import 'package:hola_mundo/alerts/alerta.dart';
import 'package:hola_mundo/util/msj_toast.dart';
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
  List<String> copiaTareas = [];

  ///segunda parte///////////////////
  late FormController _buscadorController;

  @override
  void initState() {
    super.initState();
    _formController = FormController(controllers: {'tarea': true});
    _buscadorController = FormController(controllers: {'busqueda': true});
    //_formController.controller("tarea").text='';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: SideMenu(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          child: Icon(Icons.add),
          onPressed: () async {
            _formController.controller("tarea").text = '';
            //_formController.reset();
            setState(() {});
            dynamic result = await ShowAlerta.showAlerta(
              context: context,
              formController: _formController,
              mensaje: "Hola Mundo",
              titulo: "AÑADIR TAREA",
            );

            if (result.runtimeType == bool) {
              return;
            }

            tareas.add(result);
            copiaTareas.add(result);
            setState(() {});
          }),
      appBar: AppBar(
        title: const Text("TAREAS"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 10),
                width: size.width,
                height: 50,
                //color: Colors.yellow,
                child: Row(
                  children: [
                    Container(
                      width: size.width / 1.3,
                      height: 50,
                      child: Form(
                        key: _buscadorController.key,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              FocusScope.of(context).unfocus();
                              return 'Ingrese un texto para buscar';
                            }
                            return null;
                          },
                          autofocus: true,
                          decoration: const InputDecoration(
                            labelText: 'Buscador',
                            hintText: "Ingrese Tarea",
                            border:
                                OutlineInputBorder(), // Agrega un borde alrededor del campo de texto
                          ),
                          onChanged: (v) {
                            if (v == "") {
                              //tareas=copiaTareas;
                              tareas = List<String>.from(copiaTareas);
                              setState(() {});
                              return;
                            }

                            tareas =
                                tareas.where((t) => t.contains(v)).toList();
                            setState(() {});
                          },
                          controller:
                              _buscadorController.controller("busqueda"),
                        ),
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.search))
                  ],
                ),
              ),
              /*Container(
                width: size.width,
                height: 200,
                child: Row(
                  children: [
                    Form(
                      key: _buscadorController.key,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            FocusScope.of(context).unfocus();
                            return 'Ingrese un texto para buscar';
                          }
                          return null;
                        },
                        autofocus: true,
                        decoration: const InputDecoration(
                          labelText: 'Buscador',
                          hintText: "Ingrese Tarea",
                          border:
                              OutlineInputBorder(), // Agrega un borde alrededor del campo de texto
                        ),
                        controller: _buscadorController.controller("busqueda"),
                      ),
                    ),
                  ],
                ),
              ),*/
              SizedBox(
                height: 10,
              ),
              Container(
                //color:Colors.red,
                width: size.width,
                height: size.height / 1.5,
                child: ListView.builder(
                  itemCount: tareas.length,
                  itemBuilder: (contet, index) {
                    String tareaIndex = tareas[index];
                    return Slidable(
                      key: const ValueKey(0),
                      /*startActionPane: ActionPane(
                        motion:ScrollMotion(),
                        //dismissible:DismissiblePane(onDismissed: () {}),
                        children:[
                          /*SlidableAction(
                            onPressed:(a){},
                            backgroundColor:Color(0xFFFE4A49),
                            foregroundColor:Colors.white,
                            icon:Icons.delete,
                            label:'Delete',
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
                            onPressed: (a) async {
                              bool resp = await ShowAlerta.alertConfirmacion(
                                  context,
                                  "Confirmacion",
                                  "¿Estas seguro de eliminar esta tarea ${tareas[index]}?");

                              if (!resp) {
                                return;
                              }

                              tareas.removeAt(index);
                              copiaTareas.removeAt(index);
                              setState(() {});
                              ToastMsjWidget.displayMotionToast(context,
                                  mensaje: "Tarea eliminado con exito",
                                  tiempoespera: 1,
                                  type: ToastType.success,
                                  onChange: null);
                            },
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            //label:'Eliminar',
                          ),
                          SlidableAction(
                            onPressed: (_) async {
                              bool resp = await ShowAlerta.alertConfirmacion(
                                  context,
                                  "Confirmacion",
                                  "¿Estas seguro de editar esta tarea ${tareas[index]}?");

                              if (!resp) {
                                return;
                              }
                              _formController.controller("tarea").text =
                                  tareas[index];
                              dynamic result = await ShowAlerta.showAlerta(
                                  context: context,
                                  formController: _formController,
                                  mensaje: "Hola Mundo",
                                  titulo: "AÑADIR TAREA");

                              if (result.runtimeType == bool) {
                                return;
                              }

                              tareas[index] = result;
                              copiaTareas[index] = result;
                              //tareas.add(result);
                              setState(() {});
                            },
                            backgroundColor: const Color(0xFF0392CF),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            //label:'Editar',
                          ),
                        ],
                      ),
                      //The child of the Slidable is what the user sees when the
                      //component is not dragged.
                      child: Column(
                        children: [
                          ListTile(
                            leading: SizedBox(
                                width: 32,
                                height: 32,
                                child:
                                    Image.asset("assets/images/TareaPNG.png")),
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
              ),
            ],
          ),
        ),
      )),
    );
  }
}
