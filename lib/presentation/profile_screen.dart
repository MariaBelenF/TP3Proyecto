// ignore_for_file: prefer_const_constructors

import 'package:cine_practica/core/app_router.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:cine_practica/presentation/bottom_navigation_bar.dart';
import 'package:cine_practica/presentation/initial_screen.dart';
import 'package:cine_practica/presentation/profile_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  static const String name = 'ProfileScreen';
  UserManager userManager = UserManager();
  static Usuario? currentUser;

ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    currentUser = userManager.getLoggedUser();

    return Scaffold(
      appBar: AppBar(
        title: Text(currentUser!.userName),
      ),
      body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              GestureDetector(
              onTap: () {
                context.pushNamed(ProfileInfoScreen.name);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.6),
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.account_circle_sharp),
                      onPressed: () {
                        context.pushNamed(ProfileInfoScreen.name);
                      },
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Mis datos',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
            onPressed:(){
                context.goNamed(InitialScreen.name);
                userManager.logoutUser();
            }, 
            child: Text('Log out')
            ),
          ],
          
      
      ),
        bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}

