
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hola_mundo/model/producto_map.dart';
import 'package:http/http.dart' as http;

class ProductoService{

     static String urlApiJSON="";

     static Future<void>initialize()async{

       final apiurlApi=dotenv.env["LOCAL_JSON"];
       urlApiJSON=apiurlApi.toString();
     }

     static Future<Map<String,dynamic>>modificarProducto({required String nombre,
       required String precio,required int id
     })async{

       String url1="${urlApiJSON}/productos/${id}";
       var url=Uri.parse(url1);
       Map<String, dynamic>mapResponse={};
       String jsonEnviado=createJson(nombre:nombre,precio:precio);

       try{

         final response=await http.put(
           url,
           headers: {
             'Content-Type': 'application/json',
           },
           body: jsonEnviado,
         );

         if(response.statusCode==200){
           mapResponse.addAll({"success":true});
           return mapResponse;
         }


       }catch(ex){

         mapResponse.addAll({"success":false});
         mapResponse.addAll({"body":false});
       }

       return mapResponse;
     }


     static Future<Map<String,dynamic>>eliminarProductos({required int id})async{
       await initialize();
       String url1="${urlApiJSON}/productos/${id}";
       var url=Uri.parse(url1);
       Map<String,dynamic>mapResponse={};
       try{

         var headers={
           'Content-Type': 'application/json',
           //"Authorization":"Bearer $token"
         };

         final response=await http.delete(
           url,
           headers:headers,
         );

         print("response consulta productos-->"+response.body.toString());

         if(response.statusCode==200){

           mapResponse.addAll({"success":true});
           return mapResponse;
         }
         mapResponse.addAll({"success":false});
         mapResponse.addAll({"body":response.body});
         return mapResponse;

       }catch(ex){

         mapResponse.addAll({"success": false});
         mapResponse.addAll({"body": ex.toString()});
         return mapResponse;
       }
       return mapResponse;
     }


     static Future<Map<String,dynamic>>guardarProducto({required String nombre,
     required String precio
     })async{

       String url1="${urlApiJSON}/productos";
       var url=Uri.parse(url1);
       Map<String, dynamic>mapResponse={};
       String jsonEnviado=createJson(nombre:nombre,precio:precio);

       try{

          final response=await http.post(
            url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEnviado,
          );

          if(response.statusCode==201){
            mapResponse.addAll({"success": true});
            return mapResponse;
          }


       }catch(ex){

         mapResponse.addAll({"success": false});
       }

       return mapResponse;
     }


     static Future<Map<String,dynamic>>consultarProductos()async{
       await initialize();
       String url1="${urlApiJSON}/productos";
       var url=Uri.parse(url1);
       Map<String,dynamic>mapResponse={};
       try{

         var headers={
           'Content-Type': 'application/json',
           //"Authorization":"Bearer $token"
         };

         final response=await http.get(
           url,
           headers:headers,
         );

         print("response consulta productos-->"+response.body.toString());

         if(response.statusCode==200 || response.statusCode==400){

            mapResponse.addAll({"success":true});
            mapResponse.addAll({"body":ProductoMap.productoMapConverter(response.body)});
            return mapResponse;
         }
         mapResponse.addAll({"success": false});
         mapResponse.addAll({"body": response.body});
         return mapResponse;

       }catch(ex){

         mapResponse.addAll({"success": false});
         mapResponse.addAll({"body": ex.toString()});
         return mapResponse;
       }
       return mapResponse;
     }

     static String createJson(
         {required String nombre,
           required String precio,
          }){
       Map<String,String>data={
         "nombre":nombre,
         "precio":precio
       };
       return jsonEncode(data);
     }







}