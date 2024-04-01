import 'package:flutter/widgets.dart';

class ContadorProvider extends ChangeNotifier {
  int contador = 0;

  void sumar() {
    contador++;
    notifyListeners();
  }

  void restar() {
    contador--;
    notifyListeners();
  }
}
