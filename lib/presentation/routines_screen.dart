// ignore_for_file: prefer_const_constructors

import 'package:cine_practica/core/entities/Routine.dart';
import 'package:cine_practica/core/entities/TypeOfTraining.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:cine_practica/presentation/bottom_navigation_bar.dart';
import 'package:cine_practica/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/routines_getter_service.dart';

class RoutinesScreen extends StatefulWidget {
  static const String name = 'RoutinesScreen';
  const RoutinesScreen({super.key});

  @override
  _RoutinesScreenState createState() => _RoutinesScreenState();
}

class _RoutinesScreenState extends State<RoutinesScreen> {
  UserManager manager = UserManager();
  late Usuario? loggedUser = manager.getLoggedUser();
  final RoutinesGetterService getter = RoutinesGetterService();  
  // late List<Routine> rutinas = getter.getRoutines();

  
   List<Routine>? rutinas=[
    Routine(title: 'Rutina 1', description: 'Descripcion', duration: 11, exercises: [], aim: 11, 
    typeOfTraining: TypeOfTraining.GainWeight, id: 1)
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
    // print('${getter.getRoutines()}');
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
                itemCount: rutinas?.length,
                itemBuilder: (BuildContext context, int index) {
                  Routine rutina = rutinas![index];
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
