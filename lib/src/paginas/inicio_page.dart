

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';




import 'package:peliculas_app/src/widgets/card_swiper_widget.dart';
import 'package:peliculas_app/src/widgets/movies_horizontal_widget.dart';

class InicioPage extends StatelessWidget {


final peliculaProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Inicio page'),
        backgroundColor: Colors.indigoAccent,

      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
           onPressed: (){

           })
      ],

      ),

      body: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swipeTarjetas(),
            _footer( context )
          ],
        ),
                
              )
        
            );
          }
        
  

  Widget _swipeTarjetas() {

    
return FutureBuilder(

  future: peliculaProvider.getEnCines(),
  builder: (BuildContext context, AsyncSnapshot<List> snapshot) {


    if(snapshot.hasData){
      return CardSwiper(

      peliculas: snapshot.data
      );
    }else{

      return Container(
        child: Center(
          child: CircularProgressIndicator()
          )
      );
    }



    
  }

);
   
  }

  Widget _footer( BuildContext context) {

final _screenSize = MediaQuery.of(context).size;

    return Container(
      width: _screenSize.width * 0.50,
      height: _screenSize.height * 1.0,
      child: Column(

  children: <Widget>[
    //Asi centralizamos los estilos y fuentes que tendra mi app
    Text('Populares', style: Theme.of(context).textTheme.subhead),

  SizedBox( height: 5.0),

  FutureBuilder(

    future: peliculaProvider.getPopulares(),
    
    builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {

      //De esta forma se verifica si la peticion del future tiene respuesta
    if(snapshot.hasData){ 

      return  HorizontalScroll(peliculas: snapshot.data );

      
    }else{

      return Center(child: CircularProgressIndicator());
    }

  }
    )

    ]
      ),

    );
  }







}