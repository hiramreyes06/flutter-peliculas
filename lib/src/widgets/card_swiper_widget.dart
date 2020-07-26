

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';



class CardSwiper extends StatelessWidget {

  
  //Para poder acceder
  final List<Pelicula> peliculas;

//Agregamos un parametro obligatorio
  CardSwiper({ @required this.peliculas });
  
  @override
  Widget build(BuildContext context) {

//de esta forma extramos la dimension de la pantalla
final _screenSize = MediaQuery.of(context).size;

    return Container(
      //Esta propiedad hace que haga un espacio desde arriba para abajo
       padding: EdgeInsets.only( top: 10.0),

      //asi especificamos el tamaño del container
     
      height: _screenSize.height *0.40,

      child: Swiper(

        layout: SwiperLayout.STACK,
        //Es necesario especificar el tamaño
        itemWidth: _screenSize.width * 0.8,
        itemHeight: _screenSize.height * 2.0,

        //Esto se va a encargar de hacer un foreach para las peliculas
          itemBuilder: (BuildContext context, int index){

        //Es necesario crear un id unico para que el tag del widget Hero, no
        //tenga errores      
            peliculas[index].idUnico = '${peliculas[index].id}-stack';

           
            return Hero(

              tag: peliculas[index].idUnico,
                 //Este widget agrega border redondos
                child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),

        //Este widget sirve para mostral una imagen con animacion
                child: GestureDetector(
                       
                    child: FadeInImage(
                    //Necesita una imagen de mediante una web url
                    image: NetworkImage( peliculas[index].getImagenUrl() ),

                    //Esto va a mostrar si no se encuentra la imagen
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    //Esto hace que la imagen tome el tamaño que dispone
                    fit: BoxFit.cover,
                  ),

                onTap: (){

                Navigator.pushNamed(context, 'peliculaDetalle', arguments: peliculas[index] );

                },


                )

              
              ),
            );
            
             
          },

//Aqui se especifica la cantidad de objetos que contendra para el iterador
          itemCount: peliculas.length,
          //Esta es una propiedad para que visualmente muestre la cantidad
          //pagination: new SwiperPagination(),

          //Con esto muestra los botones para desplazar el swiper
          //control: new SwiperControl(),
        )
    
    );
  }
}