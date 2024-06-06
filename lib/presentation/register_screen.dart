import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cine_practica/core/entities/TypeOfTraining.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:cine_practica/presentation/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const String name = 'RegisterScreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _registerUserTFController = TextEditingController();
  final TextEditingController _registerPasswordTFController = TextEditingController();
  final TextEditingController _registerMailTFController = TextEditingController();
  final TextEditingController _registerAgeTFController = TextEditingController();
  TypeOfTraining dropdownValue = TypeOfTraining.LoseWeight;
  final UserManager userManager = UserManager();

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
                    width: 300,
                    child: TextField(
                      controller: _registerUserTFController,
                      decoration: InputDecoration(
                        hintText: 'Ingrese su nombre completo',
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _registerMailTFController,
                      decoration: InputDecoration(
                        hintText: 'Ingrese su correo electrónico',
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _registerAgeTFController,
                      decoration: InputDecoration(
                        hintText: 'Ingrese su edad',
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
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
                    width: 300,
                    child: TextField(
                      controller: _registerPasswordTFController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Ingrese una contraseña',
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_registerUserTFController.text.isEmpty ||
                          _registerPasswordTFController.text.isEmpty ||
                          _registerMailTFController.text.isEmpty ||
                          _registerAgeTFController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Por favor, ingrese todos los campos'),
                          ),
                        );
                      } else {
                        int? age = int.tryParse(_registerAgeTFController.text);
                        if (age == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Por favor, ingrese una edad válida'),
                            ),
                          );
                          return;
                        }

                        Usuario usuario = Usuario(
                          userName: _registerUserTFController.text,
                          password: _registerPasswordTFController.text,
                          age: age,
                          training: dropdownValue,
                          mail: _registerMailTFController.text,
                          currentRoutine: null,                          
                        );

                        try {
                          await userManager.registerUser(usuario, dropdownValue.index);
                          userManager.setLoggedUser(usuario);
                          context.goNamed(HomeScreen.name, extra: usuario);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error al registrar usuario: $e'),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('Registrarme'),
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

