import 'package:flutter/material.dart';

import 'package:flutter_cartelera_cine/src/pages/home_page.dart';
import 'package:flutter_cartelera_cine/src/pages/pelicula_detalle_page.dart';
   
  void main() => runApp(MyApp());
   
  class MyApp extends StatelessWidget {

    @override
    Widget build(BuildContext context) {

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: '/',
        routes: {
          '/'       : (BuildContext context) => HomePage(),
          'detalle' : (BuildContext context) => PeliculaDetallePage()
        },
      );
    
    }

  }