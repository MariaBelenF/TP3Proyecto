import 'package:cine_practica/core/app_router.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/presentation/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'HomeScreen';
  final Usuario usuario;

  HomeScreen({Key? key,required this.usuario}) : super(key: key);

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
        ));
  }
}
