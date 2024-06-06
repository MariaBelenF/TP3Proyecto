import 'package:cine_practica/core/entities/TypeOfTraining.dart';
import 'package:cine_practica/core/entities/UserManager.dart';

class Profile{
UserManager manager = UserManager();

  void setEditedUser(String name, String email, int Age, String password, TypeOfTraining training){
   manager.updateUserInfo(name, email, Age, password, training);
  }
}
