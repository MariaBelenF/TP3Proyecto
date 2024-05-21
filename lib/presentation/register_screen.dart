import 'package:cine_practica/core/entities/TypeOfTraining.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:cine_practica/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const String name = 'RegisterScreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<Usuario> usuarios = [];
  final TextEditingController _registerUserTFController = TextEditingController();
  final TextEditingController _registerPasswordTFController = TextEditingController();
  final TextEditingController _registerMailTFController = TextEditingController();
  final TextEditingController _registerAgeTFController = TextEditingController();


  TypeOfTraining dropdownValue = TypeOfTraining.LossWeight; // Valor inicial de tipo de entrenamiento
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
                      controller: _registerAgeTFController,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 26, 26, 34),
                        hintText: 'Ingrese su edad',
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
                    width: 300,
                    child: DropdownButton<TypeOfTraining>(
                      value: dropdownValue,
                      onChanged: (TypeOfTraining? newValue) {
                        if (newValue != null) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        }
                      },
                      items: TypeOfTraining.values.map((TypeOfTraining value) {
                        return DropdownMenuItem<TypeOfTraining>(
                          value: value,
                          child: Text(value.toString().split('.').last),
                        );
                      }).toList(),
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
                          _registerPasswordTFController.text.isEmpty ||
                          _registerMailTFController.text.isEmpty ||
                          _registerAgeTFController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Por favor, ingrese todos dos campos'),
                          ),
                        );
                      } else {
                        int? age = int.tryParse(_registerAgeTFController.text);
                        Usuario usuario = Usuario(
                          userName: _registerUserTFController.text,
                          password: _registerPasswordTFController.text,
                          age: age ?? 0,
                          training: dropdownValue!,
                          mail: _registerMailTFController.text,
                        );
                        userManager.agregarUsuario(usuario);
                        userManager.setLoggedUser(usuario);
                        context.goNamed(
                          HomeScreen.name,
                          extra: usuario,
                        );
                      }
                    },
                    child: const Text(
                      'Registrarme',
                      style: TextStyle(color: Color.fromARGB(255, 173, 0, 101)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
