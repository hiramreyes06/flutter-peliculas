import 'package:flutter/material.dart';




import 'package:peliculas_app/src/paginas/inicio_page.dart';
import 'package:peliculas_app/src/routes/routes.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(

      //Esta es la etiqueta que muestra que es una beta
      debugShowCheckedModeBanner: false,
      title: 'Aplicacion de noticias',
      
      initialRoute: '/',

      //En este constructor se emite el evento de una ruta desconocida
      onGenerateRoute: (RouteSettings settings){

        print('Se quzo navegar a: '+settings.arguments);

//Esto redirecciona si la pagina no fue encontrada
   return MaterialPageRoute(
        builder: ( BuildContext context) => InicioPage()
      );
      },

      routes: getRutas(),

    );
    
    
  }
}
