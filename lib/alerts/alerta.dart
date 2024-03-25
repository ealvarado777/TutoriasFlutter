import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_controller/form_controller.dart';
import 'package:hola_mundo/util/msj_toast.dart';

class ShowAlerta {
  static Future<dynamic> showAlerta(
      {required BuildContext context,
      required String titulo,
      required String mensaje,
      required FormController formController}) async {
    dynamic result = await showDialog<dynamic>(
      context: context,
      barrierDismissible:
          false, // esto debe ser false si quieres forzar una selección
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            titlePadding: EdgeInsets.all(
                0), // Añadir esta línea para eliminar el padding del título
            title: Container(
              margin: EdgeInsets.only(top: 15),
              width: double
                  .infinity, // Hace que el container tome todo el ancho posible
              alignment: Alignment.center, // Centra el contenido del container
              child: Text("$titulo"),
            ),
            content: SingleChildScrollView(
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  /*Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [Text(""), Text(""), Text("")],
                    ),
                  ),*/
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                              child: Form(
                                  key: formController.key,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            FocusScope.of(context).unfocus();
                                            return 'Este campo es obligatorio';
                                          }
                                          return null;
                                        },
                                        autofocus: true,
                                        decoration: const InputDecoration(
                                          labelText: 'Tarea',
                                          hintText: "Ingrese Tarea",
                                          border:
                                              OutlineInputBorder(), // Agrega un borde alrededor del campo de texto
                                        ),
                                        controller:
                                            formController.controller("tarea"),
                                      ),
                                      /*Text(
                                        mensaje,
                                        style:TextStyle(fontSize: 12),
                                        textAlign:TextAlign.center,
                                        maxLines:5,
                                        overflow:TextOverflow.ellipsis,
                                      ),*/
                                    ],
                                  ))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //FlutterLogo(size:100.0)
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      //formController.reset();
                      //formController.save();

                      Navigator.of(context).pop(false); //Retorna true
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          fontSize:
                              10, // Ajusta este valor para cambiar el tamaño del texto
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (!formController.validate()) {
                        return;
                      }
                      //formController.reset();
                      formController.save();
                      String tareaValue =
                          formController.controller("tarea").text;

                      ToastMsjWidget.displayMotionToast(context,
                          mensaje: "Tarea agregada con exito",
                          tiempoespera: 5,
                          type: ToastType.success,
                          onChange: () {});
                      formController.reset();
                      Navigator.of(context).pop(tareaValue);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                      child: Text(
                        'Aceptar',
                        style: TextStyle(
                          fontSize:
                              10, // Ajusta este valor para cambiar el tamaño del texto
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    return result ?? "";
  }
}
