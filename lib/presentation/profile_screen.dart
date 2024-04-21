import 'package:cine_practica/core/app_router.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const String name = 'ProfileScreen';

  final Usuario usuario;

ProfileScreen({
    Key? key,
    required this.usuario
  }) : super(key: key);


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
            Text('Usuario: ${usuario.userName}'),
            Text('Contraseña: ${usuario.password}'),
            // Otros detalles del perfil aquí
          ],
        ),
      ),
    );
  }
}

