import 'package:cine_practica/core/app_router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: ThemeData(
        textTheme: GoogleFonts.philosopherTextTheme(), 
        scaffoldBackgroundColor: Color.fromARGB(255, 182, 131, 161), 
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 61, 27, 48),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
    );
  }
}
