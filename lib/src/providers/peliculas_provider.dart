
//Para convertir la data a json string
import 'dart:convert';

//De esta forma importamos y lo nombramos

import 'package:http/http.dart' as http;

//Para manejar la data correctamente
import 'package:peliculas_app/src/models/pelicula_model.dart';

class PeliculasProvider{


String _apikey ='9cc6160bf98bad73e96d3437561b1079';
String _url ='api.themoviedb.org';
String _language='es_ES';


Future<List<Pelicula>> peliculasApi(Uri uri) async{

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

 return peliculasApi( url );
}


Future<List<Pelicula>>  getPopulares(){

final url= Uri.https( _url , '3/movie/popular',{
  'api_key': _apikey,
  'language': _language,
  'page': '1',
});

return peliculasApi( url );

}

}