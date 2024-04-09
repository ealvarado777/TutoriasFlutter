import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:form_controller/form_controller.dart';
import 'package:hola_mundo/view_models/registro_view_model.dart';
import 'package:provider/provider.dart';

class ComboIdentificacionWidget extends StatefulWidget {
  final BuildContext contextA;
  final FormController formController;

  const ComboIdentificacionWidget(
      {super.key, required this.contextA, required this.formController});

  @override
  State<ComboIdentificacionWidget> createState() =>
      _ComboIdentificacionWidgetState();
}

class _ComboIdentificacionWidgetState extends State<ComboIdentificacionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistroClienteViewModel>(builder: (context, item, child) {
      return DropdownSearch<Map<String, dynamic>>(
        //key: widget.formController.key,
        validator: (value) {
          if (value == null || value.isEmpty) {
            FocusScope.of(context).unfocus();
            return 'El tipo es obligatorio';
          }
          return null;
        },
        popupProps: const PopupProps.menu(
          showSelectedItems: false,
          showSearchBox: true,
          //disabledItemFn: (String s) => s.startsWith('I'),
        ),
        items: item.identificaciones,
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Tipo Identificacion",
            hintText: "Seleccione una identificacion",
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        dropdownBuilder: (context, Map<String, dynamic>? item) {
          if (item!.isNotEmpty) {
            return Text(
              item["tipo"].toString(),
              style:
                  TextStyle(fontSize: 11), // Ajusta el tamaño de la fuente aquí
            );
          }
          return Text(
            "seleccione",
            style:
                TextStyle(fontSize: 11), // Ajusta el tamaño de la fuente aquí
          );
        },
        onChanged: (e) async {
          RegistroClienteViewModel registroClienteViewModel =
              RegistroClienteViewModel();
          registroClienteViewModel.selectIdentificacion(select: e!);
        },
        selectedItem: item.identificacionSelect,
        itemAsString: (Map<String, dynamic> item) => item["tipo"].toString(),
        /*  
          
          enabled:item.escanersTransferencia.isEmpty && item.numDoc==null */
      );
    });
  }
}
