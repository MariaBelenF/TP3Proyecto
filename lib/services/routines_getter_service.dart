// import 'package:cine_practica/core/entities/Routine.dart';
// import 'package:cine_practica/core/entities/Exercise.dart';
// import 'package:cine_practica/core/entities/TypeOfTraining.dart';
// import 'package:cine_practica/core/entities/UserManager.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class RoutinesGetterService {
//   final String baseUrl = 'https://665887705c3617052648e130.mockapi.io/api';

//   Future<List<Routine>> fetchRoutines() async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/routines'),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> routinesData = jsonDecode(response.body);
//       final UserManager userManager = UserManager();
//       final int? trainingIndex = userManager.getLoggedUser()?.training?.index;

//       if (trainingIndex == null) {
//         throw Exception('No logged user or training index not set');
//       }

//       List<Routine> routines = routinesData.map((routineData) {
//         List<Exercise> exercises =
//             (routineData['exercises'] as List).map((exerciseData) {
//           return Exercise(
//             title: exerciseData['title'],
//             imageLink: exerciseData['imageLink'],
//             description: exerciseData['description'],
//           );
//         }).toList();

//         return Routine(
//           title: routineData['title'],
//           description: routineData['description'],
//           duration: routineData['duration'],
//           exercises: exercises,
//           aim: routineData['aim'],
//           typeOfTraining: TypeOfTraining.values[trainingIndex],
//         );
//       }).toList();

//        return routines.where((routine) => routine.typeOfTraining.index == trainingIndex).toList();
//     } else {
//       throw Exception('Failed to load routines');
//     }
//   }
// }


import 'package:cine_practica/core/entities/Routine.dart';
import 'package:cine_practica/core/entities/Exercise.dart';
import 'package:cine_practica/core/entities/TypeOfTraining.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class RoutinesGetterService {
//   final String baseUrl = 'https://665887705c3617052648e130.mockapi.io/api';
//   late List<Routine> _routines;

//   List<Routine> getRoutines() {
//     return _routines;
//   }

//   RoutinesGetterService() {
//     _fetchRoutines();
//   }

//   void _fetchRoutines() async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/routines'),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> routinesData = jsonDecode(response.body);
//         final UserManager userManager = UserManager();
//         final int? trainingIndex = userManager.getLoggedUser()?.training?.index;

//         if (trainingIndex == null) {
//           throw Exception('No logged user or training index not set');
//         }

//         List<Routine> routines = routinesData.map((routineData) {
//           List<Exercise> exercises = (routineData['exercises'] as List).map((exerciseData) {
//             return Exercise(
//               title: exerciseData['title'],
//               imageLink: exerciseData['imageLink'],
//               description: exerciseData['description'],
//             );
//           }).toList();

//           return Routine(
//             title: routineData['title'],
//             description: routineData['description'],
//             duration: routineData['duration'],
//             exercises: exercises,
//             aim: routineData['aim'],
//             typeOfTraining: TypeOfTraining.values[trainingIndex],
//           );
//         }).toList();

//         _routines = routines.where((routine) => routine.typeOfTraining.index == trainingIndex).toList();
//       } else {
//         throw Exception('Failed to load routines');
//       }
//     } catch (e) {
//       print('Error fetching routines: $e');
//     }
//   }

//   List<Routine>? get routines => _routines;
// }




class RoutinesGetterService {
  final String baseUrl = 'https://665887705c3617052648e130.mockapi.io/api';
  late List<Routine> _routines;

  List<Routine> getRoutines() {
    return _routines;
  }

  RoutinesGetterService() {
    _fetchRoutines();
  }

  Future<void> _fetchRoutines() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/routines'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> routinesData = jsonDecode(response.body);
        final UserManager userManager = UserManager();
        final int? trainingIndex = userManager.getLoggedUser()?.training?.index;

        if (trainingIndex == null) {
          throw Exception('No logged user or training index not set');
        }

        List<Routine> routines = routinesData.map((routineData) {
          List<Exercise> exercises = (routineData['exercises'] as List).map((exerciseData) {
            return Exercise(
              title: exerciseData['title'],
              imageLink: exerciseData['imageLink'],
              description: exerciseData['description'],
            );
          }).toList();

          return Routine(
            title: routineData['title'],
            description: routineData['description'],
            duration: routineData['duration'],
            exercises: exercises,
            aim: routineData['aim'],
            typeOfTraining: TypeOfTraining.values[trainingIndex],
          );
        }).toList();

        _routines = routines.where((routine) => routine.typeOfTraining.index == trainingIndex).toList();
      } else {
        throw Exception('Failed to load routines');
      }
    } catch (e) {
      print('Error fetching routines: $e');
    }
  }

  List<Routine>? get routines => _routines;
}
