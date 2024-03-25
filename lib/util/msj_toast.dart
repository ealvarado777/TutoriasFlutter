import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:motion_toast/motion_toast.dart';

class ToastMsjWidget {
  static void displayMotionToast(BuildContext context,
      {required String mensaje,
      required int tiempoespera,
      required ToastType type,
      required VoidCallback onChange}) {
    Color? backgroundColor;
    String? titleMSJ;
    IconData? iconopersonalizado;

    typeAlertMsj(type, (color, title, iconoMsj) {
      backgroundColor = color;
      titleMSJ = title;
      iconopersonalizado = iconoMsj;
    });

    MotionToast(
      icon: iconopersonalizado,
      primaryColor: backgroundColor!,
      position: MotionToastPosition.center,
      title: Text(
        titleMSJ!,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      toastDuration: Duration(seconds: tiempoespera),
      description: Text(
        mensaje,
      ),
      onClose: onChange,
    ).show(context);
  }

  static void typeAlertMsj(
      ToastType type, void Function(Color?, String?, IconData?) callback) {
    Color? backgroundColor;
    String? titleMSJ;
    IconData? icono;
    switch (type) {
      case ToastType.success:
        backgroundColor = Colors.green;
        titleMSJ = 'Exito';
        icono = Icons.done_all;
        break;
      case ToastType.warning:
        backgroundColor = Colors.yellow;
        titleMSJ = 'Advertencia';
        icono = Icons.warning;
        break;
      case ToastType.info:
        backgroundColor = Colors.cyan;
        titleMSJ = 'Información';
        icono = Icons.info;
        break;
      case ToastType.error:
        backgroundColor = Colors.red;
        titleMSJ = 'Error';
        icono = Icons.error;
        break;
    }
    callback(backgroundColor, titleMSJ, icono);
  }
}

enum ToastType {
  success,
  warning,
  info,
  error,
}
