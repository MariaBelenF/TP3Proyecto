import 'package:cine_practica/core/entities/TypeOfTraining.dart';

class Usuario {
  final String userName;
  final String password;
  final String mail;
  final int age;
  final TypeOfTraining training;
  
  Usuario({required this.mail, required this.userName, required this.password,required this.age, required this.training});
  
  
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
    };
  }

  String getUser(){
    return userName;
  }

  String getPassword(){
    return password;
  }
  
  String getMail(){
    return mail;
  }
}

