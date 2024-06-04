import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:cine_practica/presentation/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class ProfileInfoScreen extends StatefulWidget {
  ProfileInfoScreen({Key? key}) : super(key: key);
  static const String name = 'ProfileInfoScreen';

  @override
  _ProfileInfoScreenState createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  UserManager userManager = UserManager();
  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    final Usuario? currentUser = userManager.getLoggedUser();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis datos'),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text('Nombre y apellido'),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
                color: Colors.white.withOpacity(0.8),
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                currentUser!.userName,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            Text('E-mail'),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
                color: Colors.white.withOpacity(0.8),
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                currentUser!.getEmail(),
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            Text('Enfoque'),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
                color: Colors.white.withOpacity(0.8),
              ),
              padding: EdgeInsets.all(5),
              child: Text(
                currentUser.training!.name,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            Text('Contraseña'),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
                color: Colors.white.withOpacity(0.8),
              ),
              padding: EdgeInsets.fromLTRB(7, 0, 2, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _isObscureText
                          ? '•' * currentUser.password.length
                          : currentUser.password,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isObscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscureText = !_isObscureText;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(onPressed: () {}, child: Text('Editar', style: TextStyle(color: Color.fromARGB(239, 0, 0, 0)),)),
            )
          ],
        ),
      ),
    );
  }
}
