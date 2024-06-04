import 'package:cine_practica/core/entities/Routine.dart';
import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/presentation/calendar_screen.dart';

import 'package:cine_practica/presentation/home_screen.dart';
import 'package:cine_practica/presentation/login_screen.dart';
import 'package:cine_practica/presentation/profile_info_screen.dart';
import 'package:cine_practica/presentation/profile_screen.dart';
import 'package:cine_practica/presentation/initial_screen.dart';
import 'package:cine_practica/presentation/register_screen.dart';
import 'package:cine_practica/presentation/routine_screen.dart';
import 'package:cine_practica/presentation/routines_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => InitialScreen(),
    name: InitialScreen.name,
  ),
  GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
      name: LoginScreen.name),
  GoRoute(
    path: '/home',
    builder: (context, state) {
      return HomeScreen();
    },
    name: HomeScreen.name,
  ),
  GoRoute(
    path: '/profile',
    builder: (context, state) {
      return ProfileScreen();
    },
    name: ProfileScreen.name,
  ),
  GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
      name: RegisterScreen.name),
  GoRoute(
      path: '/calendar',
      builder: ((context, state) => CalendarScreen()),
      name: CalendarScreen.name),
  GoRoute(
      path: '/routine',
      builder: (context, state) => RoutineScreen(),
      name: RoutineScreen.name),
  GoRoute(
      path: '/routines',
      builder: (context, state) => RoutinesScreen(),
      name: RoutinesScreen.name),
  GoRoute(
      path: '/profile-info',
      builder: (context, state) => ProfileInfoScreen(),
      name: ProfileInfoScreen.name)
]);
