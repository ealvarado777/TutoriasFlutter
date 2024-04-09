import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hola_mundo/routes/routes.dart';
import 'package:hola_mundo/view_models/cliente_view_model.dart';
import 'package:hola_mundo/view_models/contador_view_model.dart';
import 'package:hola_mundo/view_models/registro_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ContadorProvider(), //QRScan //ShowMasterProvider
        ),
        ChangeNotifierProvider(
          create: (_) => ClienteViewModel(), //QRScan //ShowMasterProvider
        ), //RegistroClienteViewModel
        ChangeNotifierProvider(
          create: (_) =>
              RegistroClienteViewModel(), //QRScan //ShowMasterProvider
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: appRoutes,
        initialRoute: "HomePage",
      ),
    );
  }
}
