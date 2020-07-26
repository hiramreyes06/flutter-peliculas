

//Esta es la libreria del Stream
import 'dart:async';

//Para convertir la data a json string
import 'dart:convert';

//De esta forma importamos y lo nombramos

import 'package:http/http.dart' as http;
import 'package:peliculas_app/src/models/actores_model.dart';

//Para manejar la data correctamente
import 'package:peliculas_app/src/models/pelicula_model.dart';

class PeliculasProvider{


String _apikey ='9cc6160bf98bad73e96d3437561b1079';
String _url ='api.themoviedb.org';
String _language='es_ES';

//Asi guardamos la pagina en la que vamos
int _popularesPage =0;

//Esto sirve para optimizar el listener del scroll 
bool _cargando = false;

//Esta lista se va a encargar de guardar el total acumulado de peliculas emitidas 
//por el stream
List<Pelicula> _populares = new List();

/* 
De esta forma creamos un stream para las peliculas, con el broadcast significa
que varios widgets podran escuchar lo que el stream emita
*/
final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

//Asi declaramos una funcion encargada de emitir los valores al stream por el sink
Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

//Asi declaramos una funcion para obtener la data que omite el stream
Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

void disposeStreams(){

  //De esta forma cuando el widget se destruya se cancelara el stream
  _popularesStreamController?.close();
}

Future<List<Pelicula>> buscarPelicula( String query ) async{

final url = Uri.https( _url, '3/search/movie',{
  'api_key': _apikey,
  'language': _language,
  'query' : query
});



return await _peliculasApi(url);
  
}

Future<List<Actor>> getActores( String peliculaId ) async{

final url = Uri.https( _url, '3/movie/$peliculaId/credits',{
  'api_key': _apikey
});

final resp = await http.get(url);

final jsonString = json.decode(resp.body);

return Actores.fromJsonList( jsonString['cast'] ).actores;
  
}

Future<List<Pelicula>> _peliculasApi(Uri uri) async{

final jsonString = await http.get( uri );

// //De esta forma mapeamos la data de la peticion
   final Map<String, dynamic> mapaPelicula = json.decode( jsonString.body );
// //La lista de peliculas se encuentra en la propiedad items
// return peliculas.items;
  //Esto retorna la clase encargada de manejar la lista de peliculas
  //final mapaPeliculas = new Peliculas.fromJsonList( decodedData['results'] );

return Peliculas.fromJsonList( mapaPelicula['results'] ).items.toList();


}

Future<List<Pelicula>> getEnCines() {

//Asi creamos una url con parametros para la peticion http
final url = Uri.https( _url, '3/movie/now_playing',{
  'api_key': _apikey,
  'lenguage': _language
});

 return _peliculasApi( url );
}


Future<List<Pelicula>>  getPopulares() async{

  if( _cargando ) return[];

  _cargando= true;

  _popularesPage++;

  print('Cargando siguientes de http');
  

final url= Uri.https( _url , '3/movie/popular',{
  'api_key': _apikey,
  'language': _language,
  'page': _popularesPage.toString(),
});

//Primero extramos la lista de peliculas de la api
final listaPeliculas = await _peliculasApi( url );

//ASi guardamos en una lista las peliculas
_populares.addAll( listaPeliculas );

//Utilizamos esta funcion para emitir la lista al stream
popularesSink( _populares );

_cargando= false;

return listaPeliculas;

}

}