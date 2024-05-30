// ignore_for_file: prefer_const_constructors

import 'package:cine_practica/core/entities/Exercise.dart';
import 'package:cine_practica/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:cine_practica/presentation/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';

class RoutineScreen extends StatefulWidget {
  static const String name = 'RoutineScreen';

  @override
  _RoutineScreenState createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  final UserManager manager = UserManager();

  late List<Exercise> exercises;
  Map<int, bool> checkedStatus = {};

  @override
  void initState() {
    super.initState();
    final user = manager.getLoggedUser();
    exercises = user?.getRoutine()?.exercises ?? [];
    // Inicializar checkedStatus
    for (var i = 0; i < exercises.length; i++) {
      checkedStatus[i] = false;
    }
  }

  void _toggleExerciseDone(int index) {
    setState(() {
      exercises[index].toggleDone();
    });
  }

  void _showExerciseDetails(BuildContext context, Exercise exercise) {
    
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center( child: Text(exercise.title)) ,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  exercise.imageLink,
                  width: 200,
                  height: 200,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: 10),
                Text(exercise.description),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); //cierra el popup
                  },
                  child: Text('Cerrar'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Usuario? currentUser = manager.getLoggedUser();
    final user = manager.getLoggedUser();
    final routineTitle =
        user?.getRoutine()?.getTitle() ?? 'Sin rutina asignada';

    return Scaffold( appBar: AppBar(
        title: Text('Entrenamiento - ${routineTitle}'), 
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
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SizedBox(height: 10),
            Text(
              'Ejercicios:',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (BuildContext context, int index) {
                  Exercise exercise = exercises[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0), 
                    child: ListTile(
                       onTap: () {
                         _showExerciseDetails(context, exercise);
                      },
                      leading: Image.network(
                        exercise.imageLink,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                      title: Text(exercise.title),
                      trailing: Checkbox(
                        value: exercise.done,
                        onChanged: (bool? value) {
                          setState(() {
                            _toggleExerciseDone(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {}, child: const Text('Finalizar entrenamiento'))
          ],
        ),
      ),
    );
  }
}
