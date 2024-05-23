import 'package:cine_practica/core/app_router.dart';
import 'package:cine_practica/core/entities/Exercise.dart';
import 'package:cine_practica/core/entities/Routine.dart';
import 'package:cine_practica/core/entities/TypeOfTraining.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:flutter/foundation.dart'; 

class UserManager {
  static List<Usuario> _usuarios = [];
  static Usuario? _logged_user;
  static List<Usuario> get usuarios => _usuarios;

UserManager(){
  Exercise ejercicio1 = new Exercise(title: 'Push up', imageLink: 'https://media.istockphoto.com/id/882882258/es/vector/el-joven-afroamericana-activos-est%C3%A1-haciendo-la-empuja-hacia-arriba-el-ejercicio.jpg?s=612x612&w=0&k=20&c=oeVJw6tTg2Q54puyY1wBof74k-nDLR92WgKZfy2_ds0=', description: 'Push up');
   Routine myRoutine = Routine(
    title: 'Desafío de Fuerza Total',
    duration: 30, 
    aim: 10,
    description: 'Aumentá tu fuerza y mejorá tu estado fisico al máximo con esta rutina de 30 días',
    exercises: [ejercicio1], 
  );
  Usuario user = new Usuario(mail: 'mail@gmail.com', userName: 'Maria Belen Fontana',age: 20, training: TypeOfTraining.Strength, password: '123', currentRoutine: myRoutine);
  agregarUsuario(user);
}
  void agregarUsuario(Usuario usuario) {
    _usuarios.add(usuario);
  }

 Usuario? existeUsuario(String mail, String password) {
  try {
    return _usuarios.firstWhere((usuario) => usuario.mail == mail && usuario.password == password);
  } catch (e) {
    print('Error al buscar usuario: $e');
    return null;
  }
}
 void setLoggedUser(Usuario user){
  _logged_user = user;
 }

 Usuario? getLoggedUser(){
  return _logged_user;
 }

 void logoutUser(){
  _logged_user = null;
 }
}