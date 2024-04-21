import 'package:cine_practica/core/app_router.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:flutter/foundation.dart'; 

class UserManager {
  static List<Usuario> _usuarios = [];

  static List<Usuario> get usuarios => _usuarios;

UserManager(){
  Usuario user = new Usuario(mail: 'fontanamariabelen@gmail.com', userName: 'Maria Belen Fontana', password: '123');
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

}