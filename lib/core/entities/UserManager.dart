// import 'package:cine_practica/core/app_router.dart';
// import 'package:cine_practica/core/entities/Exercise.dart';
// import 'package:cine_practica/core/entities/Routine.dart';
// import 'package:cine_practica/core/entities/TypeOfTraining.dart';
// import 'package:cine_practica/core/entities/User.dart';
// import 'package:flutter/foundation.dart';

// class UserManager {
//   static List<Usuario> _usuarios = [];
//   static Usuario? _logged_user;
//   static List<Usuario> get usuarios => _usuarios;

// UserManager(){
//   Exercise ejercicio1 = new Exercise(title: 'Push up', imageLink: 'https://media.istockphoto.com/id/882882258/es/vector/el-joven-afroamericana-activos-est%C3%A1-haciendo-la-empuja-hacia-arriba-el-ejercicio.jpg?s=612x612&w=0&k=20&c=oeVJw6tTg2Q54puyY1wBof74k-nDLR92WgKZfy2_ds0=', description: 'Colócate en posición de plancha con las manos a la altura de los hombros y el cuerpo en línea recta. Flexiona los codos para bajar el cuerpo hasta que el pecho casi toque el suelo, manteniendo los codos a 45 grados del torso. Luego, empuja hacia arriba hasta extender completamente los brazos. Mantén el núcleo activado y la espalda recta durante todo el movimiento');
//    Exercise ejercicio2 = new Exercise(title: 'Sentadilla isométrica', imageLink: 'https://fisicalcoach.com/wp-content/uploads/2022/06/test-de-sentadilla-isometrica.jpg', description: 'Apoya la espalda contra una pared y deslízate hacia abajo hasta que las rodillas formen un ángulo de 90 grados, como si estuvieras sentado en una silla invisible. Mantén los pies a la altura de los hombros y las rodillas alineadas con los tobillos. Sostén esta posición, activando el core y asegurándote de que la espalda baja esté en contacto con la pared, durante el tiempo deseado');
//    Exercise ejercicio3 = new Exercise(title: 'Plancha', imageLink: 'https://media.vogue.es/photos/5fd243f80800022c258951da/master/w_1600%2Cc_limit/tabla-de-ejercicios2-4.jpg', description: 'Coloca los antebrazos en el suelo directamente debajo de los hombros y extiende las piernas hacia atrás apoyando las puntas de los pies. Mantén el cuerpo en una línea recta desde la cabeza hasta los talones, activando el núcleo y manteniendo la espalda recta. Sostén esta posición sin dejar que las caderas se hundan o se levanten, durante el tiempo deseado.');
//    Exercise ejercicio4 = new Exercise(title: 'Estocada', imageLink: 'https://static.vecteezy.com/system/resources/previews/008/424/322/non_2x/illustrated-exercise-guide-by-healthy-man-doing-lunges-workout-in-2-steps-for-firming-buttocks-and-legs-vector.jpg', description: 'Da un paso largo hacia adelante con una pierna y baja el cuerpo hasta que ambas rodillas formen ángulos de 90 grados. La rodilla trasera debe casi tocar el suelo y la delantera debe estar alineada con el tobillo. Mantén el torso erguido y el núcleo activado. Empuja con el talón delantero para volver a la posición inicial y repite con la otra pierna.');
//    Routine myRoutine = Routine(
//     title: 'Fuerza Total',
//     duration: 30,
//     aim: 10,
//     description: 'Aumentá tu fuerza y mejorá tu estado fisico al máximo con esta rutina de 30 días',
//     exercises: [ejercicio1, ejercicio2, ejercicio3, ejercicio4],
//   );
//   Usuario user = new Usuario(mail: 'mail', userName: 'Maria Belen Fontana',age: 20, training: TypeOfTraining.Strength, password: '123', currentRoutine: myRoutine);
//   agregarUsuario(user);
// }
//   void agregarUsuario(Usuario usuario) {
//     _usuarios.add(usuario);
//   }

//  Usuario? existeUsuario(String mail, String password) {
//   try {
//     return _usuarios.firstWhere((usuario) => usuario.mail == mail && usuario.password == password);
//   } catch (e) {
//     print('Error al buscar usuario: $e');
//     return null;
//   }
// }
//  void setLoggedUser(Usuario user){
//   _logged_user = user;
//  }

//  Usuario? getLoggedUser(){
//   return _logged_user;
//  }

//  void logoutUser(){
//   _logged_user = null;
//  }
// }

import 'package:cine_practica/core/entities/User.dart';
import '../../services/auth_service.dart';

class UserManager {
  static AuthService logger = AuthService(UserManager());
  static List<Usuario> _usuarios = [];
  static Usuario? _loggedUser;
  // static AuthService logger = AuthService();
  
  static List<Usuario> get usuarios => _usuarios;

  void agregarUsuario(Usuario usuario) {
    _usuarios.add(usuario);
  }

  Usuario? existeUsuario(String mail, String password) {
    try {
      return _usuarios.firstWhere(
          (usuario) => usuario.mail == mail && usuario.password == password);
    } catch (e) {
      print('Error al buscar usuario: $e');
      return null;
    }
  }

  void setLoggedUser(Usuario user) {
    _loggedUser = user;
  }

  Usuario? getLoggedUser() {
    return _loggedUser;
  }

  void logoutUser() {
    _loggedUser = null;
  }

  var login = (String mail, String password) async =>
      {logger.loginAndSetUser(mail, password)};
}
