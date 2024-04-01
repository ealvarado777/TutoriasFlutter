import 'package:flutter/widgets.dart';
import 'package:hola_mundo/pages/cliente_page.dart';
import 'package:hola_mundo/pages/contador_page.dart';
import 'package:hola_mundo/pages/contador_page_provider.dart';
import 'package:hola_mundo/pages/home.dart';
import 'package:hola_mundo/pages/sumar_page.dart';
import 'package:hola_mundo/pages/tareas-page.dart';
import '../pages/hola_mundo.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'HolaMundo': (_) => HolamundoPage(),
  "HomePage": (_) => HomePage(),
  "TareasPage": (_) => TareasPage(),
  "ContadorPage": (_) => ContadorPage(),
  "SumarPage": (_) => SumarPage(),
  "ContadorProvidersPage": (_) => ContadorProvidersPage(),
  "ClientePage": (_) => ClientePage()
};
