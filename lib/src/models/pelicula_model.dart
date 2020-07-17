
//Esta clase esta destinada a manejar una lista de peliculas
class Peliculas{

//Propiedad de la clase que guarda las peliculas
List<Pelicula> items = new List();

Peliculas();

//Este metodo va a recibir 
Peliculas.fromJsonList( List<dynamic> jsonList){

if( jsonList == null) return;


jsonList.forEach( ( peliculaMapa ){

//Aqui hacemos uso de la clase para instancear individualmente  
final pelicula = new Pelicula.fromJsonMap( peliculaMapa);

items.add( pelicula ); 


});

}


}

class Pelicula {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

//Este constructor va a recibir un json mapeado para inicializar 
//los valores de la clase para la instancea
  Pelicula.fromJsonMap( Map<String, dynamic> json){

//Asi asignamos los valores a las propiedades de la clase
  voteCount = json['vote_count'];
  id = json['id'];
  video = json['video'];
  //Es necesaria validar que se convierta a un double
  voteAverage = json['vote_average'] / 1;
  title = json['title'];
  popularity = json['popularity'] / 1;
  posterPath = json['poster_path'];
  originalLanguage = json['original_language'];
  originalTitle = json['original_title'];
  genreIds =  json['genre_ids'].cast<int>();
  backdropPath = json['backdrop_path'];
  adult= json['adult'];
  overview = json['overview'];
  releaseDate = json['relase_date'];


  }


 String getImagenUrl(){

    if( posterPath == null){
      return 'https://onlinezebra.com/wp-content/uploads/2019/01/error-404-not-found.jpg';
    }else{

      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }


  }


}


