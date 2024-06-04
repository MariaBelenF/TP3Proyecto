// import 'package:cine_practica/core/entities/Routine.dart';
// import 'package:cine_practica/core/entities/TypeOfTraining.dart';

// class Usuario {
//   final String userName;
//   final String password;
//   final String mail;
//   final int age;
//   final TypeOfTraining training;
//   final Routine? currentRoutine;
//   final int? daysDone; //dias de rutina hechos
//   Usuario({required this.mail, required this.userName, required this.password,required this.age, required this.training, required this.currentRoutine, this.daysDone});
 
//   Map<String, dynamic> toJson() {
//     return {
//       'userName': userName,
//       'password': password,
//     };
//   }

//   String getUser(){
//     return userName;
//   }

//   String getPassword(){
//     return password;
//   }
  
//   String getMail(){
//     return mail;
//   }
//    @override
//   String toString() {
//     return '$userName ';
//   }

  

//   Routine? getRoutine(){
//     return currentRoutine;
//   }
// }


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
  final int? daysDone; //dias de rutina hechos
  Usuario(
      {required this.mail,
      required this.userName,
      required this.password,
      required this.age,
      required this.training,
      required this.currentRoutine,
      this.id,
      this.daysDone});


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
  }
}

