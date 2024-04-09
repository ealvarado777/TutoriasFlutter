import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hola_mundo/interceptor/custom_interceptor.dart';
import 'package:hola_mundo/model/clientes_map.dart';
import 'package:hola_mundo/model/tipo_identificacion_map.dart';
import 'package:http/http.dart' as http;

class ClienteService{

  static String urlApiJSON='';

  static Future<void>initialize()async{
    final apiurlApi=dotenv.env['LOCAL_JSON'];
    urlApiJSON=apiurlApi.toString();
  }

  static Future<Map<String,dynamic>>eliminarCliente({required int id})async{
    String url1="${urlApiJSON}/clientes/${id}";
    var url=Uri.parse(url1);
    Map<String,dynamic>mapResponse={};

    try{

      final response=await http.delete(
        url,
        headers:{
          'Content-Type':'application/json',
        },
      );

      if(response.statusCode==200){

        mapResponse.addAll({"success":true});
        return  mapResponse;
      }


    }catch(ex){

      mapResponse.addAll({"success":false});
      mapResponse.addAll({"body":ex.toString()});
    }

     return mapResponse;
  }


  static Future<Map<String,dynamic>>guardarCliente(
      {required String nombres,
      required String apellidos,
      required String tipoIdentificacion,
      required String numIdentificacion})async{
    String url1 = "${urlApiJSON}/clientes";
    var url = Uri.parse(url1);
    Map<String, dynamic>mapResponse={};
    String jsonEnviado=createJson(
        nombres: nombres,
        apellidos: apellidos,
        tipoIdentificacion: tipoIdentificacion,
        numIdentificacion: numIdentificacion);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEnviado,
      );

      if (response.statusCode == 201) {
        mapResponse.addAll({"success": true});
        return mapResponse;
      }
    } catch (ex) {
      mapResponse.addAll({"success": false});
    }

    return mapResponse;
  }

  static Future<Map<String, dynamic>> consultarClientes() async {
    await initialize();
    String url1 = "${urlApiJSON}/clientes";
    var url = Uri.parse(url1);
    Map<String, dynamic> mapResponse = {};
    /* var dio = Dio();
    dio.interceptors.add(CustomInterceptor()); */
    try {
      var headers = {
        'Content-Type': 'application/json',
        //"Authorization":"Bearer $token"
      };

      print("url cliente-->" + url1.toString());

      final response = await http.get(
        url,
        headers: headers,
      );

      print("response clientes----->" + response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 400) {
        mapResponse.addAll({"success": true});
        mapResponse
            .addAll({"body": ClienteMap.clienteMapConverter(response.body)});
        return mapResponse;
      }

      mapResponse.addAll({"success": false});
      mapResponse.addAll({"body": response.body});
      return mapResponse;
    } catch (ex, e) {
      print("error-->" + ex.toString());
      mapResponse.addAll({"success": false});
      mapResponse.addAll({"body": ex.toString()});
    }
    return mapResponse;
  }

  static Future<Map<String, dynamic>> consultarTipoIdentificacion() async {
    await initialize();
    String url1 = "${urlApiJSON}/tiposIdentificaciones";
    var url = Uri.parse(url1);
    Map<String, dynamic> mapResponse = {};
    /*var dio=Dio();
    dio.interceptors.add(CustomInterceptor());*/
    try {
      var headers = {
        'Content-Type': 'application/json',
        //"Authorization":"Bearer $token"
      };

      print("url consultarTipoIdentificacion-->" + url1.toString());

      final response = await http.get(
        url,
        headers: headers,
      );

      print("response consultarTipoIdentificacion----->" +
          response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 400) {
        mapResponse.addAll({"success": true});
        mapResponse.addAll({
          "body":
              TipoIdentificacionMap.identificacionMapConverter(response.body)
        });
        return mapResponse;
      }

      mapResponse.addAll({"success": false});
      mapResponse.addAll({"body": response.body});
      return mapResponse;
    } catch (ex, e) {
      print("error-->" + ex.toString());
      mapResponse.addAll({"success": false});
      mapResponse.addAll({"body": ex.toString()});
    }
    return mapResponse;
  }

  static String createJson(
      {required String nombres,
      required String apellidos,
      required String tipoIdentificacion,
      required String numIdentificacion}) {
    Map<String, String> data = {
      "nombres": nombres,
      "apellidos": apellidos,
      "tipoIdentificacion": tipoIdentificacion,
      "numIdentificacion": numIdentificacion
      /*"company":company,*/
    };

    return jsonEncode(data);
  }
}
