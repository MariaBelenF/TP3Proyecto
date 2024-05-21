import 'package:flutter/material.dart';
import 'package:cine_practica/presentation/bottom_navigation_bar.dart';

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({super.key});

static const String name = 'RoutineScreen';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}