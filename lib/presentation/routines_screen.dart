// ignore_for_file: prefer_const_constructors

import 'package:cine_practica/core/entities/Routine.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:cine_practica/presentation/bottom_navigation_bar.dart';
import 'package:cine_practica/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoutinesScreen extends StatefulWidget {
  static const String name = 'RoutinesScreen';
  const RoutinesScreen({super.key});

  @override
  _RoutinesScreenState createState() => _RoutinesScreenState();
}

class _RoutinesScreenState extends State<RoutinesScreen> {
  UserManager manager = UserManager();
  late Usuario? loggedUser = manager.getLoggedUser();
  List<Routine> rutinas = [
    Routine(
      title: 'Comienzos de running',
      description:
          'Rutina diseñada para principiantes. Incluye ejercicios de calentamiento, caminatas y trotes suaves para desarrollar resistencia y mejorar la técnica de carrera. Ideal para quienes desean comenzar a correr de manera gradual y segura',
      duration: 10,
      exercises: List.empty(),
      aim: 1,
      image: 'assets/running1.png',
    ),
    Routine(
      title: 'Mejorar la Resistencia',
      description:
          'Rutina enfocada en mejorar la resistencia para carreras. Incluye entrenamientos de intervalos, carreras a ritmo constante y sesiones de resistencia muscular. Ideal para corredores que desean aumentar su resistencia y rendimiento en competencias de larga distancia',
      duration: 10,
      exercises: List.empty(),
      aim: 0,
      image: 'assets/resistencia.png',
    ),
  ];

  void _showRoutineDetails(BuildContext context, Routine rutina) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(rutina.title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Text(rutina.description),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); 
                    },
                    child: Text('Cerrar'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (loggedUser != null) {
                        loggedUser!.setRoutine(rutina);
                        Navigator.of(context).pop(); 
                      }
                    },
                    child: Text('Comenzar rutina'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Image path: ${rutinas[0].image}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Rutinas'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              context.pushNamed(ProfileScreen.name);
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 16.0, 16.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                'Rutina actual: ${loggedUser?.getRoutine()?.getTitle() ?? "Ninguna"}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: rutinas.length,
                itemBuilder: (BuildContext context, int index) {
                  Routine rutina = rutinas[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        _showRoutineDetails(context, rutina);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                          color: Colors.white.withOpacity(0.6), 
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: rutina.image != null
                                    ? DecorationImage(
                                        image: AssetImage(rutina.image!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                color:
                                    rutina.image == null ? Colors.grey : null,
                              ),
                              child: rutina.image == null
                                  ? Icon(Icons.image, color: Colors.white)
                                  : null,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    rutina.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Duración: ${rutina.duration} minutos',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
