import 'package:cine_practica/core/entities/Routine.dart';
import 'package:cine_practica/core/entities/TypeOfTraining.dart';

class Usuario {
  final String? id;
  final String userName;
  final String password;
  final String mail;
  final int age;
  final TypeOfTraining? training;
  Routine? currentRoutine;
  final List<DateTime> timesDone; 
  Usuario(
      {required this.mail,
      required this.userName,
      required this.password,
      required this.age,
      required this.training,
      required this.currentRoutine,
      this.id,
      List<DateTime>? timesDone,
     }) : this.timesDone = timesDone ?? [];


  @override
  String toString() {
    return '$userName';
  }

  Routine? getRoutine() {
    return currentRoutine;
  }

String getEmail(){
  return this.mail;
}
  void setRoutine(Routine rutina){
    currentRoutine = rutina;
     timesDone.clear();
  }

  
  void addDayDone(DateTime day) {
    timesDone.add(day);
    timesDone.sort((a, b) => a.compareTo(b));
  }


  void removeDayDone(DateTime day) {
    timesDone.remove(day);
  }

}

