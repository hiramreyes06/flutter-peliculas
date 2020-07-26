


import 'package:flutter/material.dart';
import 'package:peliculas_app/src/paginas/inicio_page.dart';
import 'package:peliculas_app/src/paginas/pelicula_detalle.dart';

Map<String, WidgetBuilder>  getRutas(){

return <String, WidgetBuilder>{

'/': (BuildContext context) => InicioPage(),
'peliculaDetalle' : (BuildContext context) => PeliculaDetalle()

};


}