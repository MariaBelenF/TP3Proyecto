// ignore_for_file: prefer_const_constructors

import 'package:cine_practica/core/app_router.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:cine_practica/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  static const String name = 'LoginScreen';

  LoginScreen({super.key});

  final TextEditingController _userTextFieldController =
      TextEditingController();
  final TextEditingController _passwordTextFieldController =
      TextEditingController();
  final UserManager userManager = UserManager();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 209, 128, 175),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  'assets/logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: _userTextFieldController,
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(255, 26, 26, 34),
                    filled: true,
                    hintText: 'Ingrese su email',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 187, 100, 151)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(
                      color: Color.fromARGB(
                          255, 187, 100, 151)), // Cambiar color del texto
                ),
              ),
              SizedBox(height: 20), // Espacio entre los textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: _passwordTextFieldController,
                  obscureText: true, // Para ocultar la contraseña
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(255, 26, 26, 34),
                    filled: true,
                    hintText: 'Ingrese su contraseña',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 187, 100, 151)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(
                      color: Color.fromARGB(
                          255, 187, 100, 151)), // Cambiar color del texto
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 32, 32, 34),
                    elevation: 5,
                  ),
                  onPressed: () {
                    if (_userTextFieldController.text.isEmpty ||
                        _passwordTextFieldController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Por favor, ingrese los dos campos'),
                        ),
                      );
                    } else {
                      userManager.login(_userTextFieldController.text,
                          _passwordTextFieldController.text);
                      Usuario? usuario = userManager.getLoggedUser();
                      if (usuario != null) {
                        context.goNamed(HomeScreen.name);
                        userManager.setLoggedUser(usuario);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Las credenciales no coinciden con ningun usuario registrado'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Color.fromARGB(255, 173, 0, 101)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
