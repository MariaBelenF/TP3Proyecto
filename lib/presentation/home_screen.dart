import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'HomeScreen';
  final Usuario usuario;

  HomeScreen({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              context.pushNamed(ProfileScreen.name, extra: usuario);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bienvenida'),
            Text(usuario.userName),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: 0, // Índice del elemento seleccionado inicialmente
        onTap: (int index) {
          // Navegar a la pantalla correspondiente según la pestaña seleccionada
          switch (index) {
            case 0:
              context.goNamed(HomeScreen.name);
              break;
            case 1:
              // Aquí deberías cambiar 'CalendarScreen.name' por el nombre de la pantalla de tu calendario
              context.goNamed('CalendarScreen');
              break;
            case 2:
              // Aquí deberías cambiar 'TrainingScreen.name' por el nombre de la pantalla de tu entrenamiento
              context.goNamed('RoutineScreen');
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
