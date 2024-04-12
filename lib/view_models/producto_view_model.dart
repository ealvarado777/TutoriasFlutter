import 'package:flutter/widgets.dart';
import 'package:hola_mundo/services/producto_service.dart';
import 'package:hola_mundo/util/loading_overlay.dart';
import 'package:hola_mundo/util/msj_toast.dart';

class ProductoViewModel extends ChangeNotifier{

  List<Map<String,dynamic>>productos=[];//la que se muestra
  List<Map<String,dynamic>>copiaProductos=[];

  static final ProductoViewModel _instance=ProductoViewModel._internal();

  ProductoViewModel._internal();

  factory ProductoViewModel() => _instance;






  void iniciar({required BuildContext contextA}){

    consultarProductos(contextA:contextA);
  }

  Future<void>consultarProductos({required BuildContext contextA})async{

        LoadingOverlay loadingOverlay=LoadingOverlay();
        loadingOverlay.show(contextA);
        Map<String,dynamic>body=await ProductoService.consultarProductos();
        loadingOverlay.hide();
        bool success=body["success"];
        dynamic response=body["body"];

        if(!success && response.runtimeType==String){
           ToastMsjWidget.displayMotionToast(contextA,mensaje:response.toString(),
               tiempoespera:5,type:ToastType.error,onChange:(){});
           return;
        }

        if(!success && response.runtimeType==Map){
          Map<String, dynamic> mapResponse = response;
          String mensaje=mapResponse.containsKey("message")?mapResponse["message"]:mapResponse.toString();
          ToastMsjWidget.displayMotionToast(contextA,mensaje:mensaje,
              tiempoespera:5,type:ToastType.error,onChange:(){});
          return;
        }
        productos=response;
        productos=productos.reversed.toList();
        copiaProductos=List<Map<String,dynamic>>.from(productos);
        notifyListeners();
  }

  void asignarProductos({required List<Map<String,dynamic>>c}){
    productos=c;
    notifyListeners();
  }

  void buscarProducto({required String filtro}){
    if(filtro.isEmpty){
      productos=List<Map<String, dynamic>>.from(copiaProductos);
      notifyListeners();
      return;
    }

    productos=copiaProductos
        .where((producto)=>producto["nombre"]
        .toString()
        .toLowerCase()
        .contains(filtro.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void eliminarProducto(
      {required int idProducto,required BuildContext contextA}) async{

    Map<String,dynamic>mapProducto=
    await ProductoService.eliminarProductos(id:idProducto);
    bool success=mapProducto["success"];
    if (!success){
      ToastMsjWidget.displayMotionToast(contextA,
          mensaje: mapProducto["body"],
          tiempoespera: 5,
          type: ToastType.error,
          onChange: null);
      return;
    }

    consultarProductos(contextA:contextA);
    ToastMsjWidget.displayMotionToast(contextA,
        mensaje:"producto eliminado con exito",
        tiempoespera: 5,
        type: ToastType.success,
        onChange: null);
  }





}