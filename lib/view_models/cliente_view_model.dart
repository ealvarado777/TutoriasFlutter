import 'package:flutter/widgets.dart';
import 'package:hola_mundo/services/cliente_service.dart';
import 'package:hola_mundo/util/loading_overlay.dart';
import 'package:hola_mundo/util/msj_toast.dart';

class ClienteViewModel extends ChangeNotifier {

  List<Map<String, dynamic>> clientes = [];//la que se muestra

  List<Map<String,dynamic>>copiaClientes=[];

  static final ClienteViewModel _instance = ClienteViewModel._internal();

  ClienteViewModel._internal();

  factory ClienteViewModel() => _instance;

  void asignarClientes({required List<Map<String, dynamic>> c}) {
    clientes = c;
    notifyListeners();
  }

  void addClientes({required Map<String, dynamic> m}) {
    clientes.add(m);
    notifyListeners();
  }

  void iniciar({required BuildContext contextA}) {
    consultarClientes(contextA: contextA);
  }

  Future<void> consultarClientes({required BuildContext contextA}) async {
    LoadingOverlay loadingOverlay = LoadingOverlay();
    loadingOverlay.show(contextA);
    final Map<String, dynamic> body = await ClienteService.consultarClientes();
    loadingOverlay.hide();
    bool success = body["success"];
    dynamic response = body["body"];

    if (!success && response.runtimeType == String) {
      ToastMsjWidget.displayMotionToast(contextA,
          mensaje: response.toString(),
          tiempoespera: 5,
          type: ToastType.error,
          onChange: () {});
      return;
    }

    if (success && response.runtimeType == Map) {
      Map<String, dynamic> mapResponse = response;

      String mensaje = mapResponse.containsKey("message")
          ? mapResponse["message"]
          : response.toString();

      ToastMsjWidget.displayMotionToast(contextA,
          mensaje: mensaje.toString(),
          tiempoespera: 5,
          type: ToastType.error,
          onChange: () {});
      return;
    }
    clientes=response;
    clientes=clientes.reversed.toList();
    copiaClientes=List<Map<String,dynamic>>.from(clientes);
    notifyListeners();
  }

  void buscarCliente({required String filtro}){

       if(filtro.isEmpty){
         clientes=List<Map<String,dynamic>>.from(copiaClientes);
         notifyListeners();
         return;
       }

       clientes=copiaClientes.where((cliente)=>cliente["nombres"].toString().contains(filtro)).toList();
       notifyListeners();

  }


  void eliminarCliente({required int idCliente,
  required BuildContext contextA
  })async{

      Map<String,dynamic>mapCliente=await ClienteService.eliminarCliente(id:idCliente);
      bool success=mapCliente["success"];
      if(!success){

        ToastMsjWidget.displayMotionToast(contextA,mensaje:mapCliente["body"],
            tiempoespera:5,type:ToastType.error,onChange:null);
        return;
      }

      consultarClientes(contextA:contextA);
      ToastMsjWidget.displayMotionToast(contextA,mensaje:"Cliente eliminado con exito",
          tiempoespera:5,type:ToastType.success,onChange:null);


  }




}
