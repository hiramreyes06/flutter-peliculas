
class Actores{

final List<Actor> actores = new List();

Actores.fromJsonList( List<dynamic> jsonList){

if( jsonList == null ) return;


jsonList.forEach( (actor) => actores.add( new Actor.fromJsonMap(actor) ));

}


}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });


  Actor.fromJsonMap( Map<String, dynamic>json ){

    castId = json['cast_id'];
    character= json['character'];
    creditId= json['credit_id'];
    gender= json['gender'];
    id= json['id'];
    name= json['name'];
    order= json['order'];
    profilePath= json['profile_path'];

  }

  String getImagenUrl(){

    if( profilePath == null){
      return 'https://onlinezebra.com/wp-content/uploads/2019/01/error-404-not-found.jpg';
    }else{

      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }


  }


}
