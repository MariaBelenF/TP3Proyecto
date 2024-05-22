import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:flutter/material.dart';
import 'package:cine_practica/presentation/bottom_navigation_bar.dart';

class ExerciseScreen extends StatelessWidget {
  static const String name = 'ExerciseScreen';

  final UserManager manager = UserManager();

  @override
  Widget build(BuildContext context) {
    final Usuario? user = manager.getLoggedUser();

    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rutina: ${user?.getRoutine()?.getTitle() ?? 'Sin rutina asignada'}',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Ejercicio: ${user!.getRoutine()!.exercises[0].title}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Descripcion: ${user!.getRoutine()!.exercises[0].description}'
            ),
            SizedBox(height: 10,),
              Image.network(
              user!.getRoutine()!.exercises[0].imageLink,
              width: 200, // Ancho de la imagen
              height: 200, // Alto de la imagen
              fit: BoxFit.cover, // Ajuste de la imagen dentro del contenedor
            ),
          ],
        ),
      ),
    );
  }
}
