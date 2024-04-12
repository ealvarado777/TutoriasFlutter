import 'package:flutter/widgets.dart';
import 'package:form_controller/form_controller.dart';
import 'package:hola_mundo/services/producto_service.dart';
import 'package:hola_mundo/util/loading_overlay.dart';
import 'package:hola_mundo/util/msj_toast.dart';
import 'package:hola_mundo/view_models/producto_view_model.dart';

class RegistroProductoViewModel extends ChangeNotifier{


     RegistroProductoViewModel._internal();

     static final RegistroProductoViewModel _instance=
         RegistroProductoViewModel._internal();

     factory RegistroProductoViewModel()=>_instance;

     LoadingOverlay loadingOverlay=LoadingOverlay();

     ProductoViewModel productoViewModel=ProductoViewModel();

     void init({required FormController formController,
       required Map<String,dynamic>producto
     }){

       limpiar(formController:formController);
       validarProducto(producto:producto,formController:formController);
     }

     void limpiar({required FormController formController}){

       formController.reset();
     }

     void validarProducto({required Map<String,dynamic>producto,
     required FormController formController
     }){

       if(producto.isNotEmpty){
           formController.set("nombre",producto["nombre"]);
           formController.set("precio",producto["precio"]);
       }
     }

     void modificarProducto({required FormController formController,
       required BuildContext contextA,
       required Map<String,dynamic>producto
     })async{

       LoadingOverlay loadingOverlay=LoadingOverlay();
       loadingOverlay.show(contextA);
       final Map<String,dynamic>body=await ProductoService.modificarProducto(
           id:producto["id"],
           nombre:formController.controller("nombre").text.toString(),
           precio:formController.controller("precio").text.toString()
       );
       bool success=body["success"];
       if(!success){
         loadingOverlay.hide();
         ToastMsjWidget.displayMotionToast(contextA,
             mensaje: "No se pudo modificar producto",
             tiempoespera: 5,
             type: ToastType.info,
             onChange: () {});

         return;
       }
       loadingOverlay.hide();
       ToastMsjWidget.displayMotionToast(contextA,
           mensaje:"producto modificado con exito",
           tiempoespera:5,
           type:ToastType.success,
           onChange:(){});
       limpiar(formController: formController);
       productoViewModel.iniciar(contextA: contextA);
       Navigator.of(contextA).pop();
       notifyListeners();
       return;





     }



     void registrarProducto({required FormController formController,
     required BuildContext contextA,required Map<String,dynamic>producto
     })async{

        if(!formController.validate()){
            return;
        }

        if(producto.isNotEmpty){
          modificarProducto(formController:formController,contextA:contextA,
          producto:producto
          );
          return;
        }



        LoadingOverlay loadingOverlay=LoadingOverlay();
        loadingOverlay.show(contextA);
        Map<String,dynamic>body=await ProductoService.guardarProducto(nombre:formController.controller("nombre").text.toString(),
            precio:formController.controller("precio").text.toString());

        bool success=body["success"];
        dynamic mensaje=body["body"];

        if(!success){
          loadingOverlay.hide();
          ToastMsjWidget.displayMotionToast(contextA,
              mensaje:mensaje.toString(),
              tiempoespera: 5,
              type: ToastType.info,
              onChange: () {});
          return;
        }

        loadingOverlay.hide();
        ToastMsjWidget.displayMotionToast(contextA,
            mensaje:"producto guardado con exito",
            tiempoespera:5,
            type:ToastType.success,
            onChange:(){});

        productoViewModel.iniciar(contextA:contextA);
        Navigator.of(contextA).pop();
        notifyListeners();
        return;







     }




}