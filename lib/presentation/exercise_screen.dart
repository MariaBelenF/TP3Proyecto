import 'package:flutter/material.dart';
import 'package:cine_practica/presentation/bottom_navigation_bar.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}