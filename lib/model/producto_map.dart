
import 'dart:convert';

class ProductoMap{

  static List<Map<String,dynamic>>productoMapConverter(String str){
    List<Map<String,dynamic>>productosMap=[];

    List<Map<String,dynamic>>dataConverter=
    List<Map<String,dynamic>>.from(json.decode(str));
    dataConverter.forEach((data){
      Map<String,dynamic>mapaData={
        "id":data['id']??"",
        "nombre":data['nombre']??"",
        "precio":data["precio"]??""
      };
      productosMap.add(mapaData);
    });

    return productosMap;

  }


}