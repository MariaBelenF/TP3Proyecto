import 'package:cine_practica/core/entities/Exercise.dart';

class Routine {
  final String title;
  final String description;
  final int duration;
  final List<Exercise> exercises;
  final int aim;
  final String? image;
  
   //esto es de user

  Routine({
    required this.title,
    required this.description,
    required this.duration,
    required this.exercises,
    required this.aim,
    this.image,
    
  });

  int getDuration() {
    return this.duration;
  }

  String getTitle() {
    return title;
  }


}

