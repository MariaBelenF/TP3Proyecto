import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:cine_practica/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);

  static const String name = 'RegisterScreen';
  List<Usuario> Usuarios = [];
  final TextEditingController _registerUserTFController = TextEditingController();
  final TextEditingController _registerPasswordTFController = TextEditingController();
  final TextEditingController _registerMailTFController = TextEditingController();
  UserManager userManager = UserManager();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background2.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Bienvenido/a a FitConnect'),
                  SizedBox(
                    width: 300, // Ancho deseado para el TextField
                    child: TextField(
                      controller: _registerUserTFController,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 26, 26, 34),
                        hintText: 'Ingrese su nombre completo',
                        hintStyle: TextStyle(color: Color.fromARGB(255, 26, 0, 15)),
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: TextStyle(color: Color.fromARGB(255, 187, 100, 151)),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300, // Ancho deseado para el TextField
                    child: TextField(
                      controller: _registerMailTFController,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 26, 26, 34),
                        hintText: 'Ingrese su correo electrónico',
                        hintStyle: TextStyle(color: Color.fromARGB(255, 26, 0, 15)),
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: TextStyle(color: Color.fromARGB(255, 187, 100, 151)),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300, // Ancho deseado para el TextField
                    child: TextField(
                      controller: _registerPasswordTFController,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 26, 26, 34),
                        hintText: 'Ingrese una contraseña',
                        hintStyle: TextStyle(color: Color.fromARGB(255, 26, 0, 15)),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 26, 26, 34)),
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      style: TextStyle(color: Color.fromARGB(255, 187, 100, 151)),
                    ),
                  ),
                   SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 32, 32, 34),
                  elevation: 5,
                ),
                onPressed: () {
                  if (_registerUserTFController.text.isEmpty ||
                      _registerPasswordTFController.text.isEmpty || _registerMailTFController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, ingrese todos dos campos'),
                      ),
                    );
                  } else {
                    Usuario usuario = Usuario(
                      userName: _registerUserTFController.text,
                      password: _registerPasswordTFController.text,
                      mail: _registerMailTFController.text,
                    );
                    userManager.agregarUsuario(usuario);
                    context.goNamed(
                      HomeScreen.name,
                      extra: usuario
                    );
                  }
                },
                child: const Text(
                  'Registrarme',
                  style: TextStyle(color: Color.fromARGB(255, 173, 0, 101)),
                ),
              )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
