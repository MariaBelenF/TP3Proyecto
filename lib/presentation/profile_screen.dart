import 'package:cine_practica/core/app_router.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:cine_practica/presentation/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  static const String name = 'ProfileScreen';
  UserManager userManager = UserManager();
  

ProfileScreen({
    Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             ElevatedButton(
            onPressed:(){
                context.goNamed(InitialScreen.name);
                userManager.logoutUser();
            }, 
            child: Text('Log out'))
          ],
        ),
      ),
    );
  }
}

