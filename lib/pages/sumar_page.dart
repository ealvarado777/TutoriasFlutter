import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_controller/form_controller.dart';
import 'package:hola_mundo/widgets/side_menu.dart';

class SumarPage extends StatefulWidget {
  const SumarPage({super.key});

  @override
  State<SumarPage> createState() => _SumarPageState();
}

class _SumarPageState extends State<SumarPage> {
  late FormController _formController;
  int total = 0;

  @override
  void initState() {
    super.initState();
    _formController =
        FormController(controllers: {'numero1': true, "numero2": false});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sumatoria"),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Container(
              //color: Colors.red,
              width: size.width,
              height: size.height / 2.3,
              child: Form(
                key: _formController.key,
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  ElevatedButton(
                      onPressed: () {
                        // _formController.save();
                        _formController.reset();
                        FocusScope.of(context).unfocus();
                        setState(() {});
                        print("limpiar");
                      },
                      child: const Text("Limpiar")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Numero 1:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: size.width / 1.8,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              //FocusScope.of(context).unfocus();
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                          autofocus: true,
                          decoration: const InputDecoration(
                            labelText: 'Numero 1',
                            hintText: "Ingrese Numero 1",
                            border:
                                OutlineInputBorder(), // Agrega un borde alrededor del campo de texto
                          ),
                          controller: _formController.controller("numero1"),
                          keyboardType: TextInputType
                              .number, // Establece el tipo de teclado como numérico
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter
                                .digitsOnly // Permite solo dígitos
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Numero 2:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: size.width / 1.8,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              //FocusScope.of(context).unfocus();
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                          autofocus: true,
                          decoration: const InputDecoration(
                            labelText: 'Numero 2',
                            hintText: "Ingrese Numero 2",
                            border:
                                OutlineInputBorder(), // Agrega un borde alrededor del campo de texto
                          ),
                          controller: _formController.controller("numero2"),
                          keyboardType: TextInputType
                              .number, // Establece el tipo de teclado como numérico
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter
                                .digitsOnly // Permite solo dígitos
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (!_formController.validate()) {
                        return;
                      }

                      int numero1 =
                          int.parse(_formController.controller("numero1").text);
                      int numero2 =
                          int.parse(_formController.controller("numero2").text);
                      total = numero1 + numero2;
                      setState(() {});
                      FocusScope.of(context).unfocus();
                    },
                    child: const Text("Sumar")),
                ElevatedButton(
                    onPressed: () {
                      if (!_formController.validate()) {
                        return;
                      }
                      int numero1 =
                          int.parse(_formController.controller("numero1").text);
                      int numero2 =
                          int.parse(_formController.controller("numero2").text);
                      total = numero1 - numero2;
                      setState(() {});
                      FocusScope.of(context).unfocus();
                    },
                    child: const Text("Restar"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total :",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(total.toString())
              ],
            )
          ],
        ),
      )),
    );
  }
}
