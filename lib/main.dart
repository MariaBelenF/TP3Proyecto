import 'package:cine_practica/core/app_router.dart';
import 'package:cine_practica/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

@override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: ThemeData(
        textTheme: GoogleFonts.philosopherTextTheme(), // Configura la tipografía predeterminada
      ),
    );
  }
}