import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hola_mundo/model/clientes_map.dart';
import 'package:http/http.dart' as http;

class ClienteService {
  static String urlApiJSON = '';

  static Future<void> initialize() async {
    final apiurlApi = dotenv.env['LOCAL_JSON'];
    urlApiJSON = apiurlApi.toString();
  }

  static Future<Map<String, dynamic>> consultarClientes(
      {required String filtro}) async {
    await initialize();
    String url1 = "${urlApiJSON}/clientes";

    var url = Uri.parse(url1);

    Map<String, dynamic> mapResponse = {};

    try {
      var headers = {
        'Content-Type': 'application/json',
        //"Authorization": "Bearer $token"
      };

      print("url consultar clientes--->" + url1.toString());

      final response = await http.get(
        url,
        headers: headers,
      );

      print("response-consultarClientes->" + response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 400) {
        final Map<String, dynamic> listaCod =
            ClienteMap.clienteMapConverter(json.decode(response.body));
        mapResponse.addAll({"success": true});
        mapResponse.addAll({"body": listaCod});
      } else {
        mapResponse.addAll({"success": false});
        mapResponse.addAll({"body": response.body});
      }
    } /*on TimeoutException catch (e){
      mapResponse.addAll({"codigo": 3});
      mapResponse.addAll({"body": "Tiempo de espera superado"});
    }*/
    catch (ex) {
      mapResponse.addAll({"success": false});
      mapResponse.addAll({"body": ex.toString()});
    }
    return mapResponse;
  }
}
