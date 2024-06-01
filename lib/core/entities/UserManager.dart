import 'package:cine_practica/core/entities/User.dart';
import '../../services/auth_service.dart';
import '../../services/register_service.dart';
import '../entities/Routine.dart';

class UserManager {
  static final RegisterService registerService = RegisterService();
  static AuthService logger = AuthService(UserManager());
  static List<Usuario> _usuarios = [];
  static Usuario? _loggedUser;
  
  static List<Usuario> get usuarios => _usuarios;

  void agregarUsuario(Usuario usuario) {
    _usuarios.add(usuario);
  }

  Future<void> registerUser(Usuario usuario, int trainingId) async {
    final Routine routine = await registerService.fetchRoutine(trainingId);
    usuario.currentRoutine = routine;
    agregarUsuario(usuario);
    await registerService.registerUser(usuario, trainingId);
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
