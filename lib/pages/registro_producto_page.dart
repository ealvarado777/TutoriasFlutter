import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:form_controller/form_controller.dart';
import 'package:hola_mundo/view_models/registro_producto_view_model.dart';

class RegistroProductoPage extends StatefulWidget{

  final Map<String,dynamic>producto;

  const RegistroProductoPage({super.key,required this.producto});

  @override
  State<RegistroProductoPage> createState() => _RegistroProductoPageState();
}

class _RegistroProductoPageState extends State<RegistroProductoPage>{

  late FormController _formController;
  late RegistroProductoViewModel registroProductoViewModel;

  @override
  void initState(){
    super.initState();
    registroProductoViewModel=RegistroProductoViewModel();
    _formController=FormController(controllers:{'nombre':true});
    _formController=FormController(controllers:{'precio':true});
    SchedulerBinding.instance.addPostFrameCallback((_){

      registroProductoViewModel.init(formController:_formController,producto:widget.producto);

    });

  }

  @override
  Widget build(BuildContext context){
    final size=MediaQuery.of(context).size;
    return Scaffold(
           appBar:AppBar(
                  leading:IconButton(
                    icon:Icon(Icons.arrow_back),
                    onPressed:(){

                      Navigator.of(context).pop();
                    },
                  ),
               centerTitle:true,
               title:widget.producto.isEmpty?Text("Registro Producto"):Text("Modificar Cliente")
           ),
    );
  }


}





