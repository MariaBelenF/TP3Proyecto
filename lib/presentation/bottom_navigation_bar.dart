import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget{
  final int currentIndex;

  const CustomBottomNavigationBar({Key? key, required this. currentIndex}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Entrenamiento',
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
          default:
            break;
        }
      },
    );
  }
}