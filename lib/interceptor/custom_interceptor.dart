import 'dart:convert';
import 'package:dio/dio.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //super.onRequest(options, handler);

    // Agregar la URL a la solicitud
    print('URL: ${options.uri}');

    // Agregar encabezados a la solicitud
    options.headers['Content-Type'] = 'application/json';
    // options.headers['Authorization']='Bearer your_token';
    // Continuar con la solicitud
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //super.onResponse(response, handler);
    print("response clientes-->" + response.toString());

    /* final Map<String, dynamic> modifiedResponse = {};
    List<Map<String, dynamic>> listaData = [];

    if (response.statusCode == 200 || response.statusCode == 400) {
      listaData = List<Map<String, dynamic>>.from(
        response.data.map((item) => item as Map<String, dynamic>),
      );
      print("listaData--->" + listaData.length.toString());

      /*final Map<String, dynamic> listaCod=
          ClienteMap.clienteMapConverter(json.decode(response.data));
      response.data={
        "success": true,
        "body": listaCod
      };*/
    }else{
      response.data={"success": false, "body": response.data};
    }*/
    //Continuar con la respuesta
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    //super.onError(err, handler);
    // Continuar con el error
    handler.next(err);
  }
}
