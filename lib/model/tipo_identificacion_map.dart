import 'dart:convert';

class TipoIdentificacionMap {
  static List<Map<String, dynamic>> identificacionMapConverter(String str) {
    List<Map<String, dynamic>> identificaciones = [];

    try {
      List<Map<String, dynamic>> dataConverter =
          List<Map<String, dynamic>>.from(json.decode(str));

      dataConverter.forEach((data) {
        Map<String, dynamic> mapaData = {
          "id": data['id'] ?? "",
          "tipo": data['tipo'] ?? "",
          "minimo": data["minimo"] ?? "",
          "maximo": data["maximo"] ?? ""
        };
        identificaciones.add(mapaData);
      });
    } catch (ex) {
      print("error al formapear a un mapa en especifico----->" + ex.toString());
    }
    return identificaciones;
  }
}
