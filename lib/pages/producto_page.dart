import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hola_mundo/alerts/alerta.dart';
import 'package:hola_mundo/pages/registro_producto_page.dart';
import 'package:hola_mundo/view_models/producto_view_model.dart';
import 'package:hola_mundo/widgets/side_menu.dart';
import 'package:provider/provider.dart';
class ProductoPage extends StatefulWidget{
  const ProductoPage({super.key});

  @override
  State<ProductoPage> createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage>{
  
  bool _isSearching = false;
  final TextEditingController _searchQueryController=TextEditingController();
  late ProductoViewModel productoViewModel;
  
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    print("iniciar pagina producto");
    SchedulerBinding.instance.addPostFrameCallback((_){
      productoViewModel=ProductoViewModel();
      productoViewModel.iniciar(contextA:context);

    });
  }



  @override
  Widget build(BuildContext context){
    final size=MediaQuery.of(context).size;
    return Scaffold(
           floatingActionButton:FloatingActionButton(
               child:Icon(Icons.add),
               onPressed:(){

                 Navigator.of(context).pushNamed("formProducto");

                 Navigator.of(context).push(MaterialPageRoute(
                     builder:(context)=>RegistroProductoPage(producto:{},)));
                    //RegistroProductoPage

               },
           ),
           drawer:SideMenu(),
           appBar:AppBar(
                 centerTitle:true,
                 title:_isSearching?_buildSearchField():const Text('Productos'),
                 actions:_buildActions(context),
           ),
      body:body(size),
    );
  }

  

  Widget body(Size size){
         return SafeArea(child:SingleChildScrollView(
                child:Column(
                      children:[
                Consumer<ProductoViewModel>(builder:(context,item,child){
                    return Container(
                           width:size.width,
                           height:size.height/1.3,
                           child:ListView.builder(
                               itemCount:item.productos.length,
                               itemBuilder:(context,index){
                               Map<String,dynamic>producto=item.productos[index];

                               return Slidable(
                                 key: const ValueKey(0),
                                 endActionPane:ActionPane(
                                    motion:ScrollMotion(),
                                    children:[
                                       SlidableAction(
                                          onPressed:(e)async{

                                              bool resp=await ShowAlerta.alertConfirmacion(context,"Confirmacion",
                                                  "¿Estas seguro de eliminar este producto ${producto["nombre"]}?");

                                              if(!resp){
                                                 return;
                                              }

                                              productoViewModel.eliminarProducto(idProducto:producto["id"],contextA:context);



                                          },
                                         backgroundColor: Color(0xFFFE4A49),
                                         foregroundColor: Colors.white,
                                         icon: Icons.delete,
                                       ),
                                      SlidableAction(
                                        onPressed:(e)async{

                                          bool resp=await ShowAlerta.alertConfirmacion(context,"Confirmacion",
                                              "¿Estas seguro de editar este producto ${producto["nombre"]}?");

                                          if(!resp){
                                             return;
                                          }

                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder:(context)=>RegistroProductoPage(producto:producto,)));
                                          //RegistroProductoPage



                                        },
                                        backgroundColor: Color(0xFF0392CF),
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                      ),

                                    ],
                                 ),
                                 child:Column(
                                   children:[
                                     ListTile(
                                       leading:SizedBox(
                                           width:32,
                                           height:32,
                                           child:
                                           Image.asset("assets/images/icono_producto.jpg")),
                                       title:Text(producto["nombre"]),
                                     ),
                                     Divider()
                                   ],
                                 ),
                               );


                           }),
                    );

                }),

                      ],
                ),
         ));  
  }
  


  Widget _buildSearchField(){
    return TextField(
      controller:_searchQueryController,
      autofocus:true,
      onChanged:(e){

        productoViewModel.buscarProducto(filtro:e.toString());

      },
      decoration: InputDecoration(
        hintText: 'Buscar...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black),
      ),
      style: TextStyle(color: Colors.black, fontSize: 16.0),
    );
  }

  List<Widget> _buildActions(BuildContext contextA){
    if (_isSearching) {
      return [
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {

            setState(() {
              _isSearching = false;
              _searchQueryController.clear();
              productoViewModel.buscarProducto(filtro:"");
              FocusScope.of(contextA).unfocus();

            });
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
      ];
    }
  }



}
