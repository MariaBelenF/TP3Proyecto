// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:cine_practica/core/entities/TypeOfTraining.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/presentation/calendar_screen.dart';
import 'package:cine_practica/presentation/profile_screen.dart';
import 'package:cine_practica/presentation/routine_screen.dart';
import 'package:cine_practica/presentation/routines_screen.dart';
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
    List<DateTime> diasEntrenados = currentUser!.timesDone;
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

    Widget lastTrainingDayText;
    if (diasEntrenados.isNotEmpty) {
      lastTrainingDayText = Row(
        children: [
          Text(
              '${_getDayName(diasEntrenados.last.weekday)}, ${DateFormat('dd/MM').format(diasEntrenados.last)}'),
        ],
      );
    } else {
      lastTrainingDayText = Row(
        children: [
          IconButton(
            onPressed: () => context.goNamed(CalendarScreen.name),
            icon: Icon(Icons.alarm_rounded),
          ),
          Text('No hay entrenamientos registrados'),
        ],
      );
    }

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
        padding: EdgeInsets.fromLTRB(18.0, 30.0, 18.0, 30.0),
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
                    blurRadius: 15,
                    offset: Offset(8, 8),
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
                if (currentUser.timesDone.length ==
                    currentUser.getRoutine()!.duration) {
                  context.pushNamed(RoutinesScreen.name);
                } else {
                  context.pushNamed(RoutineScreen.name);
                }
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
                        if (currentUser.timesDone.length ==
                            currentUser.getRoutine()!.duration) {
                          context.pushNamed(RoutinesScreen.name);
                        } else {
                          context.pushNamed(RoutineScreen.name);
                        }
                      },
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        currentUser.timesDone.length ==
                                currentUser.getRoutine()!.duration
                            ? '¡Felicidades! Has completado tu rutina. Haz clic aquí para dirigirte a la sección de rutinas y comenzar una nueva'
                            : 'Comience su sesión de entrenamiento y siga progresando hacia su meta',
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
              ),
              padding: EdgeInsets.all(5),
              child: Text(
                'Mi plan de entrenamiento: ${tr?.name}',
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
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
                    currentUser.timesDone.length ==
                            currentUser.getRoutine()!.duration
                        ? 'Rutina finalizada'
                        : 'Días entrenados: ${currentUser.timesDone.length} / ${routine.duration}',
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
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(7),
              ),
              child: GestureDetector(
                onTap: () {
                  context.pushNamed(CalendarScreen.name);
                },
                child: Column(
                  children: [lastTrainingDayText],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}
