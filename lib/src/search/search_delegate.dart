
import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';


class DataSearch extends SearchDelegate{

//Esa propiedad se encargar de guardar el valor del resulado seleccionado
  String seleccionado='';

  final peliculasProvider = new PeliculasProvider();

  final peliculas =[
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam',
    'Ironman',
    'Capitan America'
  ];

  final peliculasRecientes=[
'Spiderman',
'Capitan America'
  ];


  
  //Esta propiedad se encarga crear botones del lado derecho de la barra y las 
  //acciones que tendra
  @override
  List<Widget> buildActions(BuildContext context) {
     
     return [

       IconButton(
        icon: Icon( Icons.clear),
        onPressed:(){
         
         //Existe una variable en la clase SearchDelegate llamada query es la 
         //encargada de guardar el texto del input, y asi la limpiamos
         query='';
        }
        )

     ];
    }
  
//Con esto se pueden agregar iconos o botones  de la parte izquierda de la barra
    @override
    Widget buildLeading(BuildContext context) {
      
       return IconButton(
         //Este es un tipo de boton con icono y animacion
         icon: AnimatedIcon(
           icon: AnimatedIcons.menu_arrow,
           //Es necesario agregar esta propiedad
           progress: transitionAnimation, 
           ),
          onPressed: (){

            print('Se regreso desde la busqueda');

          //De la clase heredada contiene este metodo que sirve para cerrar la pagina
            close(context, null);

          }
          );
    }
  
//Este Widget es el que se construye y se muestra cuando se selecciona alguna 
//opcion
  @override
  Widget buildResults(BuildContext context) {
    
     return Center( child: Container(
       child: Text( seleccionado ),
     ));
    }
  
    

//Con este metodo , construimos los resultados de busqueda y opciones sugeridas
  @override
  Widget buildSuggestions(BuildContext context) {

    if( query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
   
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {

        if(snapshot.hasData){

          return ListView(

          //De esta forma retornamos una lista de widgets con el map
          children:  snapshot.data.map( (pelicula){
            return ListTile(
              leading: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                 image: NetworkImage( pelicula.getImagenUrl() ),
                 width: 50.0,
                 fit: BoxFit.contain,
                 ),

                 title: Text( pelicula.title ),
                 subtitle: Text( pelicula.originalTitle ),


                 onTap: (){
                   //Para cerrar la pantalla del buscador y abrir la de peliculaDetalle
                   close(context, null);

                    //Es necesario agregarle algo a la propiedad para que no truene el Hero
                    pelicula.idUnico='';

                    //Asi reutilizamos la pantalla
                    Navigator.pushNamed(context, 'peliculaDetalle', arguments: pelicula);

                 },
            );

      

     //Es necesario para convertir el iterable del map a una lista para el children del List View
          }).toList(),  


        

          );

        }else{

        return Center(child: CircularProgressIndicator() );          
        }
        
      }
    );

  }


// //De esta forma creamos algunas opciones sugeridas con una lista de valores estaticos
//   @override
//   Widget buildSuggestions(BuildContext context) {

// //De esta forma construimos la lista de opciones sugeridas y validamos si
// //el texto del input esta vacio
//     final listaSugerida = ( query.isEmpty )
//     ? peliculasRecientes
//     //De esta forma filtramos listas mediante una condicion
//     : peliculas.where( ( pelicula ) => pelicula.toLowerCase().startsWith( query ) ).toList();
    
//     return ListView.builder(
//       itemCount: listaSugerida.length,
//       itemBuilder: (context, i) {

//         return ListTile(
//           leading: Icon(Icons.movie),
//           title: Text( listaSugerida[i] ),
//           onTap: (){

//             seleccionado = listaSugerida[i];
//             print('Se presiono una opcion sugerida');

//             //Este metodo es necesario para construir y mostrar el widget de buildResults
//             showResults(context);
            
//           },
//         );
//       },

//     );
//   }

}