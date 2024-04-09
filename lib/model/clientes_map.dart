import 'dart:convert';

class ClienteMap {
  static List<Map<String, dynamic>> clienteMapConverter(String str) {
    List<Map<String, dynamic>> clienteMap = [];

    try {
      List<Map<String, dynamic>> dataConverter =
          List<Map<String, dynamic>>.from(json.decode(str));

      dataConverter.forEach((data) {
        Map<String, dynamic> mapaData = {
          "id": data['id'] ?? "",
          "nombres": data['nombres'] ?? "",
          "apellidos": data["apellidos"] ?? "",
          "tipoIdentificacion": data["tipoIdentificacion"] ?? "",
          "numIdentificacion": data["numIdentificacion"] ?? ""
        };
        clienteMap.add(mapaData);
      });
    } catch (ex) {
      print("error al formapear a un mapa en especifico----->" + ex.toString());
    }
    return clienteMap;
  }
}
