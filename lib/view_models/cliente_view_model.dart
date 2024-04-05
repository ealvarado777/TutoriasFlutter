import 'package:flutter/widgets.dart';
import 'package:hola_mundo/services/cliente_service.dart';
import 'package:hola_mundo/util/loading_overlay.dart';
import 'package:hola_mundo/util/msj_toast.dart';

class ClienteViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> clientes = [];
  // Paso 1: Crear una instancia privada de ClienteViewModel
  static final ClienteViewModel _instance = ClienteViewModel._internal();

  // Paso 2: Constructor privado
  ClienteViewModel._internal();

  // Paso 3: Método para acceder a la instancia única
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
    clientes = response;
    notifyListeners();
  }
}
