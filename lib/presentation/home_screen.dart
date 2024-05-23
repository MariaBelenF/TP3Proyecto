import 'package:cine_practica/core/entities/TypeOfTraining.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cine_practica/presentation/bottom_navigation_bar.dart';
import 'package:cine_practica/core/entities/UserManager.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'HomeScreen';
  UserManager userManager = UserManager();
  
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final Usuario? currentUser = userManager.getLoggedUser();
    TypeOfTraining tr = currentUser!.training;
    if (currentUser == null || currentUser.currentRoutine == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(child: Text('No hay rutina asignada.')),
        bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
      );
    }

    final routine = currentUser.currentRoutine!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(currentUser.userName), 
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              context.pushNamed(ProfileScreen.name);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mi plan de entrenamiento', style: TextStyle(fontSize: 20),),
            Text('${tr.name}'),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width, 
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 61, 27, 48),
                borderRadius: BorderRadius.circular(7), 
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rutina: ${routine.title}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white), 
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Días completados: ${routine.daysDone.length} / ${routine.duration}', 
                    style: TextStyle(fontSize: 13, color: Colors.white), 
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}
