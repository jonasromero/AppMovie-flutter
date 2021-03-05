
import 'package:flutter/material.dart';

import 'package:flutter_cartelera_cine/src/models/pelicula_model.dart';
import 'package:flutter_cartelera_cine/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  String seleccion ='';
  final peliculasProvider = new PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
      // Acciones del appBar (Botones)
      return [
        IconButton(
          icon: Icon(Icons.clear), 
          onPressed: (){
            query = '';
          }
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Incono a la izquierda del Appbar
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        },
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // Crea los resultados que va a mostrar
      return Container();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    // Sugerencias al momento de escribir
    if (query.isEmpty) {
      return Container();
    }
    
    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        
        if (snapshot.hasData) {

          final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map((pelicula) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPostImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.cover,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close( context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            } ).toList(),
          );

        } else {
          return Center(
            child:  CircularProgressIndicator(),
          );
        }
      },
    );

  }

}