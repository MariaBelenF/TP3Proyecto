import 'package:cine_practica/core/entities/Exercise.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/UserManager.dart';

class RoutineLogic{
  UserManager manager = UserManager();
 
  void addTrainingDay(DateTime day, Usuario? user){
      user!.addDayDone(day);
      manager.updateLoggedUser;
      
  }

  List<Exercise> getExercises(){
      return manager.getLoggedUser()?.getRoutine()?.exercises ?? [];
  }
  
 
}