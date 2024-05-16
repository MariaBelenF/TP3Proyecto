

import 'package:cine_practica/core/entities/Exercise.dart';
import 'package:flutter/material.dart';

class Routine {
  final String title;
  final String description;
  final int duration;
  final List<Exercise> exercises;
  final int aim;
  

  const Routine({
    required this.title,
    required this.description,
    required this.duration,
    required this.exercises,
    required this.aim,
 
  });
}