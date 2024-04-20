import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/presentation/home_screen.dart';
import 'package:cine_practica/presentation/login_screen.dart';
import 'package:cine_practica/presentation/profile_screen.dart';
import 'package:cine_practica/presentation/initial_screen.dart';
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
    name: LoginScreen.name
    ),
  GoRoute(
    path: '/home',
    builder: (context, state) {
      final Map<String, dynamic> extras = state.extra as Map<String, dynamic>;
      final Map<String, dynamic> usuarioJson =
          extras['usuario'] as Map<String, dynamic>;
      final Usuario usuario = Usuario(
        userName: usuarioJson['userName'],
        password: usuarioJson['password'],
      );

      return HomeScreen(
        usuario: usuario,
      );
    },
    name: HomeScreen.name,
  ),
  GoRoute(
    path: '/profile',
    builder: (context, state) {
      final Map<String, dynamic> extras = state.extra as Map<String, dynamic>;
      final Map<String, dynamic> usuarioJson =
          extras['usuario'] as Map<String, dynamic>;
      final Usuario usuario = Usuario(
        userName: usuarioJson['userName'],
        password: usuarioJson['password'],
      );

      return ProfileScreen(
        usuario: usuario,
      );
    },
    name: ProfileScreen.name,
  ),
]);
