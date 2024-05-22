import 'package:cine_practica/core/entities/Exercise.dart';

class Routine {
  final String title;
  final String description;
  final int duration;
  final List<Exercise> exercises;
  final int aim;
  List<DateTime> daysDone;

  Routine({
    required this.title,
    required this.description,
    required this.duration,
    required this.exercises,
    required this.aim,
    List<DateTime>? daysDone,
  }) : this.daysDone = daysDone ?? [];

  int getDuration() {
    return this.duration;
  }

  String getTitle() {
    return title;
  }

  void addDayDone(DateTime day) {
    daysDone.add(day);
  }

  void removeDayDone(DateTime day) {
    daysDone.remove(day);
  }
}
