

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';

class HorizontalScroll extends StatelessWidget {
  
final List<Pelicula> peliculas;

//Al construirce el widget se inicializa la lista de peliculas
HorizontalScroll( { @required this.peliculas } );

  @override
  Widget build(BuildContext context) {

final _screenSize = MediaQuery.of(context).size;

//Novatada con el diseño con container
    return Container(
    height : _screenSize.height * 0.43,
  width: _screenSize.width,
    
    //Este widget es una colleccion
    //y sirve para desplazar widgets por la pantalla
    child: PageView(
      pageSnapping: false,
      controller: PageController(
        initialPage: 1,
        viewportFraction: 0.8
      ),

      children: _tarjetas( context ),
          ),
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