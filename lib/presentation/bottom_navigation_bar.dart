import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Añade esta línea
      backgroundColor: const Color.fromARGB(255, 61, 27, 48),
      selectedItemColor: const Color.fromARGB(255, 150, 102, 135),
      unselectedItemColor: Colors.white70, // Asegúrate de que los íconos no seleccionados sean visibles
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Progress',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Entrenamiento',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.battery_0_bar),
          label: 'Rutinas',
        ),
      ],
      currentIndex: currentIndex,
      onTap: (int index) {
        switch (index) {
          case 0:
            context.goNamed('HomeScreen');
            break;
          case 1:
            context.goNamed('CalendarScreen');
            break;
          case 2:
            context.goNamed('RoutineScreen');
            break;
          case 3:
            context.goNamed('RoutineScreen');
            break;
          default:
            break;
        }
      },
    );
  }
}
