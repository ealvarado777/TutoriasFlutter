class ClienteMap {
  static Map<String, dynamic> clienteMapConverter(Map<String, dynamic> json) {
    Map<String, dynamic> mapaCabecera = {};

    try {
      mapaCabecera.addAll({"success": json['success'] ?? false});
      mapaCabecera.addAll({"message": json['message'] ?? ""});

      List<Map<String, dynamic>> listaData = [];
      List<Map<String, dynamic>> listaDynamic = [];

      if (json['data'] != null) {
        listaDynamic = List<Map<String, dynamic>>.from(
          json["data"].map((item) => item as Map<String, dynamic>),
        );

        listaDynamic.forEach((l) {
          Map<String, dynamic> mapaData = {
            "nombres": l['nombres'] ?? "",
            "apellidos": l['apellidos'] ?? "",
            "tipoIdentificacion": l["tipoIdentificacion"] ?? "",
            "numIdentificacion": l["numIdentificacion"] ?? "",
            "fechaNacimiento": l["fechaNacimiento"] ?? ""
          };
          listaData.add(mapaData);
        });
      }
      mapaCabecera.addAll({"data": listaData});
    } catch (ex) {
      print("error al formapear a un mapa en especifico----->" + ex.toString());
    }

    return mapaCabecera;
  }
}
