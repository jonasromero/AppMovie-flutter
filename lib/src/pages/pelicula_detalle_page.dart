import 'package:flutter/material.dart';

import 'package:flutter_cartelera_cine/src/models/pelicula_model.dart';
import 'package:flutter_cartelera_cine/src/models/actores_model.dart';
import 'package:flutter_cartelera_cine/src/providers/peliculas_provider.dart';

class PeliculaDetallePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _cardsCasting(pelicula)
              ]
            )
          )
        ],
      )
    );

  }

  Widget _crearAppBar(Pelicula pelicula) {

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(pelicula.getBackgroundImg()),
          fadeInDuration: Duration(seconds: 2),
          fit: BoxFit.cover
        ),
      ),
    );

  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: NetworkImage(pelicula.getPostImg()),
                  height: 150.0
                ),
              ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pelicula.title, 
                  style: Theme.of(context).textTheme.headline5,
                  overflow: TextOverflow.ellipsis
                  ),
                Text(
                  pelicula.originalTitle, 
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star_border,  color: Colors.blue,),
                      Text(pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.headline6)
                    ],
                  )
              ],
            )
          )
        ],
      ),
    );

  }

  Widget _descripcion(Pelicula pelicula) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify
      ),
    );

  }

  Widget _cardsCasting(Pelicula pelicula) {

    final peliProvider = new PeliculasProvider();
    
    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        
        if (snapshot.hasData) {
          return _actoresPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }

  Widget _actoresPageView(List<Actor> actores) {
    
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        itemCount: actores.length,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemBuilder: (context, i) => _tarjetaActor(actores[i]),
      ),
    );

  }

  Widget _tarjetaActor(Actor actor) {

    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/loading.gif'),
              image: NetworkImage(actor.getPhotoImg()),
              height: 150.0,
              fit: BoxFit.cover
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );

  }

}
