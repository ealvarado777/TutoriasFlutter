import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:form_controller/form_controller.dart';
import 'package:hola_mundo/view_models/registro_view_model.dart';
import 'package:hola_mundo/widgets/combo_tipo_identificacion_widget.dart';
import 'package:provider/provider.dart';

class RegistrosPage extends StatefulWidget{

  final Map<String,dynamic>cliente;

  const RegistrosPage({super.key,required this.cliente});

  @override
  State<RegistrosPage> createState() => _RegistrosPageState();
}

class _RegistrosPageState extends State<RegistrosPage>{
  late FormController _formController;
  late RegistroClienteViewModel registroClienteViewModel;

  @override
  void initState(){
    super.initState();
    registroClienteViewModel=RegistroClienteViewModel();
    _formController=FormController(controllers: {'nombre': true});
    _formController=FormController(controllers: {'apellido': true});
    _formController=FormController(controllers: {'identificacion': true});
    SchedulerBinding.instance.addPostFrameCallback((_){
      registroClienteViewModel.init(
          cliente:widget.cliente,
          contextA:context,formController:_formController);
    });

  }




  @override
  Widget build(BuildContext context){
    final size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle:true,
        title:widget.cliente.isEmpty?Text("Registro Cliente"):Text("Modificar Cliente"),
      ),
      body: bodytWidget(size),
    );
  }

  Widget bodytWidget(Size size){
    return SafeArea(
        child:SingleChildScrollView(
      child:Column(
        children:[
          Form(
              key:_formController.key,
              child:Column(
                children:[
                  SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          FocusScope.of(context).unfocus();
                          return 'El nombre es obligatorio';
                        }
                        return null;
                      },
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Nombre',
                        hintText: "Ingrese Nombre",
                        border:
                            OutlineInputBorder(), // Agrega un borde alrededor del campo de texto
                      ),
                      controller: _formController.controller("nombre"),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          FocusScope.of(context).unfocus();
                          return 'El apellido es obligatorio';
                        }
                        return null;
                      },
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'apellido',
                        hintText: "Ingrese Apellidos",
                        border:
                            OutlineInputBorder(), // Agrega un borde alrededor del campo de texto
                      ),
                      controller: _formController.controller("apellido"),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                      margin: EdgeInsets.only(right: 10, left: 10),
                      child: ComboIdentificacionWidget(
                        contextA: context,
                        formController: _formController,
                      )),
                  SizedBox(height: 10),
                  Consumer<RegistroClienteViewModel>(
                      builder: (context, item, child) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10, left: 10),
                      child: TextFormField(
                        onChanged: (e) {
                          //  _formController.validate();
                        },
                        validator: (value) {
                          return registroClienteViewModel.validarIdentificacion(
                              value: value, contextA: context);
                        },
                        autovalidateMode: AutovalidateMode.always,
                        enabled:
                            item.identificacionSelect.isEmpty ? false : true,
                        autofocus: true,
                        decoration: const InputDecoration(
                          labelText: 'Identificacion',
                          hintText: "Ingrese Identificacion",
                          border:
                              OutlineInputBorder(), // Agrega un borde alrededor del campo de texto
                        ),
                        controller:
                            _formController.controller("identificacion"),
                      ),
                    );
                  }),
                  SizedBox(height:10),
                  ElevatedButton(
                      onPressed:(){
                        registroClienteViewModel.registrarCliente(
                            contextA:context,formController:_formController,
                            cliente:widget.cliente);
                      },
                      child: Text("Guardar"))
                ],
              ))
        ],
      ),
    ));
  }
}
