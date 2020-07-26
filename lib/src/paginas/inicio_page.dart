

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';
import 'package:peliculas_app/src/search/search_delegate.dart';




import 'package:peliculas_app/src/widgets/card_swiper_widget.dart';
import 'package:peliculas_app/src/widgets/movies_horizontal_widget.dart';

class InicioPage extends StatelessWidget {


final peliculaProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

//Esta funcion carga las peliculas al principio y las emite al stream
    peliculaProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Inicio page'),
        backgroundColor: Colors.indigoAccent,

      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
           onPressed: (){

             //Este es un metodo que retorna un future que resuelve el resultado
             //de alguna busqueda, 
             showSearch(
               context: context,
               //De esta forma se usa la barra de busqueda personalizada que creamos
                delegate: DataSearch(),
                
                //Con esta propiedad podemos inicializar el texto de la buscqueda
                query: ''
                
                 );
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
//Es necesario el stream que va estar al pendiente
//Siempre va ha estar esperando a que llegue la data emitida para construir el widget
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

//Widget de horizontal scroll para descargar y mostrar peliculas progresivamente
  Widget _footer( BuildContext context) {

final _screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      
      child: Column(

  children: <Widget>[
    //Asi centralizamos los estilos y fuentes que tendra mi app
    Text('Populares', style: Theme.of(context).textTheme.subtitle1),

  SizedBox( height: 5.0),

  StreamBuilder(

    stream: peliculaProvider.popularesStream,
    
    builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {

      //De esta forma se verifica si la peticion del future tiene respuesta
    if(snapshot.hasData){ 

      return  HorizontalScroll(
        peliculas: snapshot.data,

  //De esta forma enviamos la definicion de un metodo completo como argumento
        siguientePagina: peliculaProvider.getPopulares,
         );

      
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