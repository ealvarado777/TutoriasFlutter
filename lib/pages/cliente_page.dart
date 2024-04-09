import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hola_mundo/alerts/alerta.dart';
import 'package:hola_mundo/pages/registro_cliente.dart';
import 'package:hola_mundo/view_models/cliente_view_model.dart';
import 'package:hola_mundo/widgets/side_menu.dart';
import 'package:provider/provider.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({super.key});

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage>{
  bool _isSearching = false;
  final TextEditingController _searchQueryController=TextEditingController();

  late  ClienteViewModel clienteViewModel;

  @override
  void initState(){
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_){
      iniciar();
    });
  }

  void iniciar(){
    clienteViewModel=ClienteViewModel();
    clienteViewModel.iniciar(contextA: context);
  }

  @override
  Widget build(BuildContext context){
    final size=MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton:_floatinButtonWidget(),
      drawer:SideMenu(),
      appBar:AppBar(
        centerTitle: true,
        title:_isSearching?_buildSearchField() : const Text('Clientes'),
        actions:_buildActions(context),
      ),
      body:body(size),
    );
  }

  Widget body(Size size) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(children: [
        Consumer<ClienteViewModel>(builder: (context, item, child) {
          return Container(
            width: size.width,
            height: size.height / 1.3,
            child: ListView.builder(
              itemCount:item.clientes.length,
              itemBuilder:(context,index){
                Map<String,dynamic>cliente=item.clientes[index];
                return Slidable(
                    key:const ValueKey(0),
                    endActionPane:ActionPane(motion:const ScrollMotion(),
                    children:[
                      SlidableAction(
                         onPressed:(e)async{

                           bool resp=await ShowAlerta.alertConfirmacion(
                               context,
                               "Confirmacion",
                               "¿Estas seguro de eliminar esta cliente ${cliente["nombres"]}?");

                           if(!resp){
                             return;
                           }

                           clienteViewModel.eliminarCliente(idCliente:cliente["id"],
                               contextA:context);

                         },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                      ),
                      SlidableAction(
                        onPressed:(e)async{

                          bool resp=await ShowAlerta.alertConfirmacion(
                              context,
                              "Confirmacion",
                              "¿Estas seguro de editar este cliente ${cliente["nombres"]}?");

                          if(!resp){
                            return;
                          }

                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegistrosPage(cliente:cliente)));


                        },
                        backgroundColor:const Color(0xFF0392CF),
                        foregroundColor:Colors.white,
                        icon:Icons.edit,
                      )
                    ],
                    ),
                    child:Column(
                children:[
                ListTile(
                leading: SizedBox(
                    width: 32,
                    height: 32,
                    child:
                    Image.asset("assets/images/icono_persona.png")),
                title: Text(cliente["nombres"]),
                ),
                Divider()
                ],
                ),

                );


              },
            ),
          );
        })
      ]),
    ));
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
              clienteViewModel.buscarCliente(filtro:"");
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

  Widget _buildSearchField(){
    return TextField(
      controller:_searchQueryController,
      autofocus:true,
      onChanged:(e){

        clienteViewModel.buscarCliente(filtro:e.toString());

      },
      decoration: InputDecoration(
        hintText: 'Buscar...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white54),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
    );
  }
}

class _floatinButtonWidget extends StatelessWidget{
  const _floatinButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context){
    return FloatingActionButton(
      onPressed:(){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegistrosPage(cliente:{})));
        //Navigator.of(context).pushNamed("RegistrosPage");

      },
      child: const Icon(Icons.add),
    );
  }

}
