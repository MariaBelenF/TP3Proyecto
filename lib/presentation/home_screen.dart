// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:cine_practica/core/entities/TypeOfTraining.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/presentation/profile_screen.dart';
import 'package:cine_practica/presentation/routine_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cine_practica/presentation/bottom_navigation_bar.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'HomeScreen';
  UserManager userManager = UserManager();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
  final Usuario? currentUser = userManager.getLoggedUser();
  List<DateTime> diasEntrenados = currentUser!.getRoutine()!.daysDone;
  TypeOfTraining? tr = currentUser!.training;
  
  String _getDayName(int day) {
    String es_day = "";
    switch (day) {
      case 1:
        es_day = "Lunes";
        break;
      case 2:
        es_day = "Martes";
        break;
      case 3:
        es_day = "Miércoles";
        break;
      case 4:
        es_day = "Jueves";
        break;
      case 5:
        es_day = "Viernes";
        break;
      case 6:
        es_day = "Sábado";
        break;
      case 7:
        es_day = "Domingo";
        break;
    }
    return es_day;
  }
  String dayName = _getDayName(diasEntrenados.last.weekday);
   String lastTrainingDayText = diasEntrenados.isNotEmpty
        ? '${dayName}, ${DateFormat('dd/MM').format(diasEntrenados.last)}'
        : 'No hay registros de entrenamiento';


  if (currentUser == null || currentUser.currentRoutine == null) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
    );
  }

  final routine = currentUser.currentRoutine!;

  return Scaffold(
    appBar: AppBar(
      title: Text('FIT Connect'),
      actions: [
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            context.pushNamed(ProfileScreen.name);
          },
        ),
      ],
    ),
    body: Padding(
      padding: EdgeInsets.fromLTRB(18.0, 35.0, 18.0, 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
              color: Colors.white.withOpacity(0.9),
            ),
            padding: EdgeInsets.all(15),
            child: Text(
              '¡Bienvenido/a devuelta ${currentUser?.userName}!',
              style: TextStyle(
                fontSize: 17,
                //fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Inicio rápido',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: 7),
          GestureDetector(
            onTap: () {
              context.pushNamed(RoutineScreen.name);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
                color: Colors.pink[50]!.withOpacity(0.6),
              ),
              padding: EdgeInsets.all(13),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.fitness_center_rounded),
                    onPressed: () {
                      context.pushNamed(RoutineScreen.name);
                    },
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Comience su sesión de entrenamiento y siga progresando hacia su meta',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
              color: Colors.white.withOpacity(0.7),
            ),
            padding: EdgeInsets.all(5),
            child: Text(
              'Mi plan de entrenamiento: ${tr?.name}',
              style: TextStyle(
                fontSize: 17,
                //fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20), // Aumenta este valor para más espacio
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rutina actual: ${routine.title}',
                  style: TextStyle(
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  'Días completados: ${routine.daysDone.length} / ${routine.duration}',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text('Ultimo día de entrenamiento: '),
          SizedBox(height: 10),
          Container(
             width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Text(
                  '${lastTrainingDayText}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
    ),
    bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
  );
}

}
