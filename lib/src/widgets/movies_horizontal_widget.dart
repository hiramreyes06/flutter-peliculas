

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';

class HorizontalScroll extends StatelessWidget {
  
final List<Pelicula> peliculas;

//Esta propiedad nos va a servir como auxiliar de otra funcion que va a ser recibida
final Function siguientePagina;

//Este esta es la configuracion para el widget de pageView para hacer scroll
final _pageController = new PageController(
initialPage: 1,
viewportFraction: 0.8
);

//Al construirce el widget se inicializa la lista de peliculas
HorizontalScroll( {
 @required this.peliculas,

 //De esta forma nos podemos comunicar del widget padre al hijo con la instancea
 //para pasarle el metodo del provider getPopulares
 @required this.siguientePagina 
 });

  @override
  Widget build(BuildContext context) {

final _screenSize = MediaQuery.of(context).size;


//Este controlador nos va a ayudar a que no hayan espacios blancos al inicio y al final
_pageController.addListener( () {
 
        if( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
          // Cargar siguients peliculas
          siguientePagina();
        }
 
        if ( _pageController.position.pixels <= _pageController.position.minScrollExtent+80) {
        _pageController.position.animateTo(
          _screenSize.width * 0.3,
          duration: Duration(milliseconds: 600),
          curve: Curves.linearToEaseOut,
        );
      }
 
      }
    );


// //De esta forma creamos un listener que estara al pendiente del scroll del pageController
// _pageController.addListener((){

// //Asi detectamos cuando se llega al final del scroll, para agregar mas peliculas
//   if( _pageController.position.pixels >=
//    _pageController.position.maxScrollExtent -200){

// //Esta funcion en realidad sera el metodo de getPopulares que tiene el provider
//      siguientePagina();
//      print('Se llego al tope del scroll');
//    }

// });

//Novatada con el diseño con container
    return Container(
    height : _screenSize.height * 0.43,
  width: _screenSize.width * 0.50,
    
    /* 
    El widget PageView es una colleccion y renderiza todos los widgets que 
    tenga en el children simultaneamente ademas sirve para desplazar widgets por 
    la pantalla, este widget solo es recomenable para mostra un numero definido
    de widgets
    */
    //El .builder hace que rendericemos dinamicamente los elemtos del children 
    child: PageView.builder(
      pageSnapping: false,

      controller: _pageController,
      //Es necesario que sepa el numero de elementos que va a renderizar
      itemCount: peliculas.length,

    
      //Esto hace que solo optimice lo que se demanda, en base a un index
      itemBuilder: (context, i) => _tarjeta(context, peliculas[i] )
      ,
      //children: _tarjetas( context ),

          ),
        );
    }
      

Widget _tarjeta( BuildContext context, Pelicula pelicula ){

pelicula.idUnico = '${pelicula.id}-footer';

final tarjeta = Container(
margin: EdgeInsets.only( right: 15.0),
child: Column(
children: <Widget>[

//Este widget es para animar la transaccion de una misma imagen que se utiliza
//en 2 paginas
Hero(
  //Es necesario que identifique el wisget a flotar con un id unico, necesario
  //agregar el hero en ambas paginas
  tag: pelicula.idUnico,
//De esta forma le agregamos bordes redondos a las imagenes
  child:   ClipRRect(
  
    borderRadius: BorderRadius.circular(20.0),
  
    child:   FadeInImage(
  
    
  
      placeholder: AssetImage('assets/img/no-image.jpg'),
  
    
  
      image: NetworkImage( pelicula.getImagenUrl() ),
  
    
  
      fit: BoxFit.cover
  
    
  
       ),
  
  ),
),


SizedBox( height: 2.0),

Text(
  pelicula.title,
  overflow: TextOverflow.ellipsis,
  style: Theme.of(context).textTheme.caption,
  )

],


),

);


return GestureDetector(
  child: tarjeta,
  onTap: (){

    print('Se presiono la pelicula: ${pelicula.title}');

    Navigator.pushNamed(context, 'peliculaDetalle', arguments: pelicula);
  }
);

}

List<Widget> _tarjetas(BuildContext context) {

//Esto es otra froma de iterar una lista 
 return peliculas.map( (pelicula){

return Container(
margin: EdgeInsets.only( right: 15.0),
child: Column(
children: <Widget>[

//De esta forma le agregamos bordes redondos a las imagenes
ClipRRect(
  borderRadius: BorderRadius.circular(20.0),
  child:   FadeInImage(
  
    placeholder: AssetImage('assets/img/no-image.jpg'),
  
    image: NetworkImage( pelicula.getImagenUrl() ),
  
    fit: BoxFit.cover
  
     ),
),


SizedBox( height: 2.0),

Text(
  pelicula.title,
  overflow: TextOverflow.ellipsis,
  style: Theme.of(context).textTheme.caption,
  )

],


),

);

//Es necesario convertir el iterable del map a una lista
}).toList();


}


}