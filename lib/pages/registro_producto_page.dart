import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:form_controller/form_controller.dart';
import 'package:hola_mundo/alerts/alerta.dart';
import 'package:hola_mundo/view_models/registro_producto_view_model.dart';

class RegistroProductoPage extends StatefulWidget{



  const RegistroProductoPage({super.key});

  @override
  State<RegistroProductoPage> createState() => _RegistroProductoPageState();
}

class _RegistroProductoPageState extends State<RegistroProductoPage>{

  late FormController _formController;
  late RegistroProductoViewModel registroProductoViewModel;
  Map<String,dynamic>producto={};

  @override
  void initState(){
    super.initState();
    registroProductoViewModel=RegistroProductoViewModel();
    _formController=FormController(controllers:{'nombre':false});
    _formController=FormController(controllers:{'precio':false});
    SchedulerBinding.instance.addPostFrameCallback((_){

      registroProductoViewModel.init(formController:_formController,producto:producto);

    });

  }


  @override
  void didChangeDependencies(){
    super.didChangeDependencies();

    final Map<String,dynamic>args=ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;

    producto=args["producto"]??{}; // Producto() es un
  }

  @override
  Widget build(BuildContext context){
    final size=MediaQuery.of(context).size;
    return Scaffold(
           appBar:AppBar(
                  leading:IconButton(
                    icon:Icon(Icons.arrow_back),
                    onPressed:(){

                      Map<String,dynamic>producto={};


                      Navigator.of(context).pop(producto);
                    },
                  ),
               centerTitle:true,
               title:producto.isEmpty?Text("Registro Producto"):Text("Modificar Cliente")
           ),
      body:bodytWidget(size),
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
                        validator: (value){
                          if (value == null || value.isEmpty){
                            FocusScope.of(context).unfocus();
                            return 'El producto es obligatorio';
                          }
                          return null;
                        },
                        autofocus: true,
                        decoration: const InputDecoration(
                          labelText: 'Producto',
                          hintText: "Ingrese producto",
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
                        validator: (value){
                          if (value == null || value.isEmpty){
                            FocusScope.of(context).unfocus();
                            return 'El precio es obligatorio';
                          }
                          if (!RegExp(r'^\d*\.?\d*$').hasMatch(value)) {
                            return 'Ingrese un precio válido';
                          }
                          return null;
                        },
                        autofocus:true,
                        inputFormatters:[

                          FilteringTextInputFormatter.allow(RegExp(r'^\d*[\.,]?\d*$')), // Permite números y separadores de coma o punto
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Precio',
                          hintText: "Ingrese precio",
                          border:
                          OutlineInputBorder(), // Agrega un borde alrededor del campo de texto
                        ),
                        controller: _formController.controller("precio"),
                      ),
                    ),
                    SizedBox(height:10),
                    ElevatedButton(
                        style:ButtonStyle(
                          padding:MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.only(
                              top: 20.0,
                              bottom:20.0,
                              left:30.0,
                              right:30.0,
                            ), // Ajusta el tamaño del relleno aquí
                          ),
                          backgroundColor:MaterialStateProperty.all<Color>(Colors.blue), // Cambia el color a azul
                          // Puedes cambiar otros estilos también, como el padding, la forma, etc.
                        ),

                        onPressed:()async{

                          bool resp=await ShowAlerta.alertConfirmacion(context,"Confirmacion",
                              "¿Estas seguro de guardar este producto?");

                          if(!resp){
                            return;
                          }

                          registroProductoViewModel.registrarProducto(formController:_formController,producto:producto,
                              contextA:context);



                        },child:Text("Guardar",style:TextStyle(
                                 color:Colors.black,
                                 fontSize:20

                    ),))
                  ]
              )

            )

            ]

        )

        )
    );

  }




}





