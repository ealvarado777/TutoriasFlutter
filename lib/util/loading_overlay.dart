import 'package:flutter/material.dart';
import 'package:hola_mundo/util/appSpinKitLoadings.dart';

class LoadingOverlay {
  OverlayEntry? _overlayEntry;
  bool _isShowing = false;

  void show(BuildContext context) {
    if (_isShowing) {
      // Si _isShowing es true, significa que el overlay ya se está mostrando.
      // Podemos retornar para evitar añadir otro overlay encima.
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (BuildContext overlayContext) => Stack(
        children: [
          // Fondo gris translúcido
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
            child: Center(
              child: Container(
                  width: 300,
                  height: 200,
                  child: AppSpinKitLoadings.spinkitWave),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context)?.insert(_overlayEntry!);
    _isShowing = true;
  }

  void hide() {
    print("Entré en el hide");
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry =
          null; // Establece _overlayEntry a null después de removerlo.
    }
  }

  bool isShowing() {
    return _isShowing;
  }

  /* void hide(){
    print("entre en el hide");
    _overlayEntry?.remove();
  }*/
}
