import 'package:flutter/widgets.dart';
import 'package:form_controller/form_controller.dart';
import 'package:hola_mundo/services/cliente_service.dart';
import 'package:hola_mundo/util/loading_overlay.dart';
import 'package:hola_mundo/util/msj_toast.dart';
import 'package:hola_mundo/view_models/cliente_view_model.dart';

class RegistroClienteViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> identificaciones = [];
  Map<String, dynamic> identificacionSelect = {};

  static final RegistroClienteViewModel _instance =
      RegistroClienteViewModel._internal();

  RegistroClienteViewModel._internal();

  factory RegistroClienteViewModel() => _instance;

  LoadingOverlay loadingOverlay = LoadingOverlay();

  ClienteViewModel clienteViewModel = ClienteViewModel();


  /*

  */

  asignarComboTipo({required String tipoIdentificacion}){
    print("antes de identifiacionSeletc-->"+tipoIdentificacion.toString());
    print("identificaciones->"+identificaciones.toString());
    identificacionSelect=identificaciones.singleWhere((i)=>i["tipo"]==tipoIdentificacion);
    print("despues de identifiacionSeletc-->");
    notifyListeners();
  }

  dynamic validarIdentificacion(
      {required String? value, required BuildContext contextA}){
    print("validarIdentificacion------->" + value.toString());
    if(value==null || value.isEmpty){
      //FocusScope.of(contextA).unfocus();

      return 'La Identificacion es obligatorio';
    }

    if (value.length < identificacionSelect["minimo"]) {
      return 'minimo ${identificacionSelect["minimo"]} caracteres';
    }

    if (value.length > identificacionSelect["maximo"]) {
      return 'maximo ${identificacionSelect["maximo"]} caracteres';
    }
    return null;
  }

  void selectIdentificacion({required Map<String, dynamic> select}) {
    identificacionSelect = select;
    notifyListeners();
  }

  void init(
      {required BuildContext contextA,
      required FormController formController,
      required Map<String,dynamic>cliente
      })async{

    limpiar(formController: formController);
    await consultarTipoIdentificacion(contextA:contextA);
    validarCliente(cliente:cliente,formController:formController);

  }

  validarCliente({required Map<String,dynamic>cliente,
    required FormController formController}){

    if(cliente.isNotEmpty){
      formController.set('nombre',cliente["nombres"]);
      formController.set('apellido',cliente["apellidos"]);
      formController.set('identificacion',cliente["numIdentificacion"]);
      asignarComboTipo(tipoIdentificacion:cliente["tipoIdentificacion"]);

    }

  }

  Future<void>consultarTipoIdentificacion({required BuildContext contextA}) async {
    loadingOverlay.show(contextA);
    final Map<String, dynamic> body =
        await ClienteService.consultarTipoIdentificacion();
    bool success = body["success"];
    dynamic response = body["body"];

    if (!success && response.runtimeType == String) {
      loadingOverlay.hide();
      ToastMsjWidget.displayMotionToast(contextA,
          mensaje: response.toString(),
          tiempoespera: 5,
          type: ToastType.error,
          onChange: () {});
      return;
    }

    if(success && response.runtimeType == Map){
      Map<String, dynamic> mapResponse = response;
      String mensaje = mapResponse.containsKey("message")
          ? mapResponse["message"]
          : response.toString();
      loadingOverlay.hide();
      ToastMsjWidget.displayMotionToast(contextA,
          mensaje: mensaje.toString(),
          tiempoespera: 5,
          type: ToastType.error,
          onChange: () {});
      return;
    }
    identificaciones = response;
    loadingOverlay.hide();
    print("identificaciones  identificaciones response-->" +
        identificaciones.toString());
    notifyListeners();
  }

  void modificarCliente({required FormController formController,
    required BuildContext contextA,
    required Map<String,dynamic>cliente
  })async{

      ToastMsjWidget.displayMotionToast(contextA,mensaje:"Modificado con exito",
          tiempoespera:10,type:ToastType.success,onChange:(){

          });

  }


  void registrarCliente(
      {required FormController formController,
      required BuildContext contextA,
      required Map<String,dynamic>cliente
      })async{

    if(formController.validate()){

      if(cliente.isNotEmpty){
        modificarCliente(formController:formController,
            cliente:cliente,contextA:contextA);
        return;
      }


      LoadingOverlay loadingOverlay=LoadingOverlay();
      loadingOverlay.show(contextA);
      final Map<String, dynamic>body=await ClienteService.guardarCliente(
          nombres: formController.controller("nombre").text.toString(),
          apellidos: formController.controller("apellido").text.toString(),
          numIdentificacion:
              formController.controller("identificacion").text.toString(),
          tipoIdentificacion: identificacionSelect["tipo"]);

      bool success = body["success"];
      if (!success) {
        ToastMsjWidget.displayMotionToast(contextA,
            mensaje: "No se pudo guardar cliente",
            tiempoespera: 5,
            type: ToastType.info,
            onChange: () {});
        return;
      }
      loadingOverlay.hide();
      ToastMsjWidget.displayMotionToast(contextA,
          mensaje: "Cliente guardado con exito",
          tiempoespera: 5,
          type: ToastType.info,
          onChange: () {});
      limpiar(formController: formController);
      clienteViewModel.iniciar(contextA: contextA);
      Navigator.of(contextA).pop();
      notifyListeners();
      return;
    }
  }


  void limpiar({required FormController formController}){
    formController.reset();
    identificacionSelect = {};
    notifyListeners();
  }

}
