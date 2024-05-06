import 'package:cine_practica/core/entities/Exercise.dart';
import 'package:flutter/material.dart';

class Routine {
  final String title;
  final String description;
  final int time;
  final List<Exercise> exercises;

  const Routine({
    required this.title,
    required this.description,
    required this.time,
    required this.exercises,
  });
}