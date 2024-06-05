// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cine_practica/core/entities/Exercise.dart';
import 'package:cine_practica/presentation/custom_alert_dialog.dart';
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

     if (user!.timesDone.length == user.getRoutine()!.duration) {
      Future.delayed(Duration.zero, () {
        _showCustomDialog(context);
      });
    }
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
void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog();
      },
    );
  }
  void _confirmationDetail(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Entrenamiento registrado'),
            content: Column(children: [TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('Cerrar'))],),
          );
        });
  }

  void _showExerciseDetails(BuildContext context, Exercise exercise) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text(exercise.title)),
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

  void _resetExercises() {
    setState(() {
      for (var exercise in exercises) {
        exercise.done = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Usuario? currentUser = manager.getLoggedUser();
    final user = manager.getLoggedUser();
    final routineTitle =
        user?.getRoutine()?.getTitle() ?? 'Sin rutina asignada';

    return Scaffold(
      appBar: AppBar(
        title: Text('${routineTitle}'),
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
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2)),
                ],
                color: Colors.white.withOpacity(0.9),
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                'Ejercicios:',
                style: TextStyle(fontSize: 18),
              ),
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
                onPressed: () {
                  if(user!.timesDone.length == user.getRoutine()!.duration){
                    _showCustomDialog(context);
                  }else{
                     DateTime dia = DateTime.now();
                  currentUser!.addDayDone(dia);
                  manager.updateLoggedUser;
                  _resetExercises();
                    _confirmationDetail(context);
                  }
                },
                child: const Text('Finalizar entrenamiento'))
          ],
        ),
      ),
    );
  }
}
