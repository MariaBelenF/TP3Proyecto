import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:cine_practica/presentation/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class InitialScreen extends StatelessWidget {
  static const String name = 'InitialScreen';

  InitialScreen({super.key});
  
@override
Widget build(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/background.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ocupa el espacio mínimo vertical
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 300,
                height: 300,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginButton(context),
                  SizedBox(width: 20), // Espacio entre los botones
                  RegisterButton(context),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


}

Widget RegisterButton(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      backgroundColor: Color.fromARGB(255, 32, 32, 34),
      elevation: 10,
    ),
    onPressed: () {
      context.pushNamed(
        RegisterScreen.name,
      );
    },
    child: Text(
      'Register',
      style: GoogleFonts.philosopher(
        color: Color.fromARGB(255, 187, 100, 151),
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        fontSize: 20,
      ),
    ),
  );
}

Widget LoginButton(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      backgroundColor: Color.fromARGB(255, 32, 32, 34),
      elevation: 10,
    ),
    onPressed: () {
      context.pushNamed(
        LoginScreen.name,
      );
    },
    child: Text(
      'LogIn',
      style: GoogleFonts.philosopher(
        color: Color.fromARGB(255, 187, 100, 151),
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        fontSize: 20,
      ),
    ),
  );
}
