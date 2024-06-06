import 'package:cine_practica/core/entities/Profile.dart';
import 'package:cine_practica/core/entities/TypeOfTraining.dart';
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
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _ageController;
  late TextEditingController _passwordController;
  late TypeOfTraining _selectedTraining;
  late Profile negocio = Profile();

  @override
  void initState() {
    super.initState();

    final Usuario? currentUser = userManager.getLoggedUser();
    _nameController = TextEditingController(text: currentUser?.userName);
    _emailController = TextEditingController(text: currentUser?.getEmail());
    _ageController = TextEditingController(text: currentUser?.getAge().toString());
    _passwordController = TextEditingController(text: currentUser?.password);

    _selectedTraining = TypeOfTraining.values.firstWhere(
      (training) => training.name == currentUser?.training?.name,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar perfil'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nombre y apellido'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'E-mail'),
                ),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'Edad'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: _isObscureText,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscureText = !_isObscureText;
                        });
                      },
                    ),
                  ),
                ),
                DropdownButtonFormField<TypeOfTraining>(
                  value: _selectedTraining,
                  items: TypeOfTraining.values.map((TypeOfTraining training) {
                    return DropdownMenuItem<TypeOfTraining>(
                      value: training,
                      child: Text(training.name),
                    );
                  }).toList(),
                  onChanged: (TypeOfTraining? newValue) {
                    setState(() {
                      _selectedTraining = newValue!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Enfoque'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
              negocio.setEditedUser(_nameController.text,_emailController.text,int.parse(_ageController.text),_passwordController.text, _selectedTraining);
                Navigator.pop(context);
                setState(() {});
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

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
                currentUser.getEmail(),
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
            Text('Edad'),
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
                currentUser.getAge().toString(),
                style: TextStyle(fontSize: 18),
              ),
            ),
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
              child: ElevatedButton(
                onPressed: () {
                  _showEditDialog(context);
                },
                child: Text(
                  'Editar',
                  style: TextStyle(color: Color.fromARGB(239, 0, 0, 0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
