import 'package:cine_practica/core/entities/Exercise.dart'; 
import 'package:flutter/material.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:cine_practica/presentation/bottom_navigation_bar.dart';

class RoutineScreen extends StatelessWidget {
  static const String name = 'RoutineScreen';

  final UserManager manager = UserManager();

  @override
  Widget build(BuildContext context) {
    final Usuario? user = manager.getLoggedUser();
    final List<Exercise>? exercises = user?.getRoutine()?.exercises;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
      body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 30.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${user?.getRoutine()?.getTitle() ?? 'Sin rutina asignada'}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Ejercicios:',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: exercises?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  Exercise exercise = exercises![index];
                  return ListTile(
                    title: Text(exercise.title),
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
