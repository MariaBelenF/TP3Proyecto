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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              context.pushNamed(ProfileScreen.name);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bienvenida'),
            Text(userManager.getLoggedUser().toString())
          ],
        ),
      ),
        bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}
