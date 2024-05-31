import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/entities/User.dart';
import '../core/entities/UserManager.dart';
import '../core/entities/TypeOfTraining.dart';

// class AuthService {
//   final UserManager _userManager = UserManager();
//   final String baseUrl = 'https://665887705c3617052648e130.mockapi.io/api';

//   loginAndSetUser(String email, String password) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/users'),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> users = jsonDecode(response.body);
//       for (var userData in users) {
//         if (userData['mail'] == email && userData['password'] == password) {
//           // Crear una instancia de Usuario directamente desde los datos del JSON
//           final userOK = Usuario(
//             mail: userData['mail'],
//             userName: userData['userName'],
//             password: userData['password'],
//             age: userData['age'],
//             training: TypeOfTraining.values[userData['training']],
//             currentRoutine: userData['currentRoutine'],
//             daysDone: userData['daysDone'],
//           );
//           // Establecer el usuario conectado en UserManager
//           _userManager.setLoggedUser(userOK);
//           //Agregar Usuario
//           _userManager.agregarUsuario(userOK);
//           return userOK;
//         }
//       }
//       throw Exception('User not found');
//     } else {
//       throw Exception('Failed to load users');
//     }
//   }
// }


class AuthService {
  final UserManager _userManager;

  AuthService(this._userManager);

  final String baseUrl = 'https://665887705c3617052648e130.mockapi.io/api';

  Future<void> loginAndSetUser(String email, String password) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      final List<dynamic> users = jsonDecode(response.body);
      for (var userData in users) {
        if (userData['mail'] == email && userData['password'] == password) {
          final userOK = Usuario(
            mail: userData['mail'],
            userName: userData['userName'],
            password: userData['password'],
            age: userData['age'],
            training: userData['training'] != null
                ? TypeOfTraining.values[0]
                : null,
            currentRoutine: userData['currentRoutine'],
            daysDone: userData['daysDone'],
          );

          _userManager.setLoggedUser(userOK);
          _userManager.agregarUsuario(userOK);
          return;
        }
      }
      throw Exception('User not found. Users: $users');
    } else {
      throw Exception('Failed to load users');
    }
  }
}
