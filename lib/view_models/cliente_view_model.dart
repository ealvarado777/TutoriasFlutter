import 'package:flutter/widgets.dart';

class ClienteViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> clientes = [];

  void asignarClientes({required List<Map<String, dynamic>> c}) {
    clientes = c;
    notifyListeners();
  }

  void addClientes({required Map<String, dynamic> m}) {
    clientes.add(m);
    notifyListeners();
  }
}
