import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RoutinesScreen extends StatefulWidget {
   static const String name = 'RoutinesScreen';
  const RoutinesScreen({super.key});

  @override
  _RoutinesScreenState createState() => _RoutinesScreenState();
}

class _RoutinesScreenState extends State<RoutinesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('rutinas'),
    );
  }
}