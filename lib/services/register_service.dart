import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/Routine.dart';
import 'package:cine_practica/core/entities/Exercise.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterService {
  final String baseUrl = 'https://665887705c3617052648e130.mockapi.io/api';

  Future<void> registerUser(Usuario usuario, int trainingId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userName': usuario.userName,
        'password': usuario.password,
        'mail': usuario.mail,
        'age': usuario.age,
        'training': usuario.training?.name,
        'idCurrentRoutine': trainingId,
        'daysDone': 0,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register user');
    }
  }

  Future<Routine> fetchRoutine(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/routines/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch routine');
    }

    final routineData = jsonDecode(response.body);
    List<Exercise> exercises = (routineData['exercises'] as List)
        .map((exerciseData) => Exercise(
              title: exerciseData['title'],
              imageLink: exerciseData['imageLink'],
              description: exerciseData['description'],
            ))
        .toList();

    return Routine(
      title: routineData['title'],
      description: routineData['description'],
      duration: routineData['duration'],
      exercises: exercises,
      aim: routineData['aim'],
      
    );
  }
}
