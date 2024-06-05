// custom_alert_dialog.dart
import 'package:cine_practica/presentation/routine_screen.dart';
import 'package:cine_practica/presentation/routines_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAlertDialog extends StatelessWidget {

  const CustomAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('¡Felicitaciones!'),
      content: Text('Ya terminaste esta rutina..¿deseas comenzar otra?'),
      actions: <Widget>[
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: const Text('No por ahora..'),
        ),
        TextButton(
          onPressed: (){
            context.goNamed(RoutinesScreen.name);
          },
          child: const Text('¡Comencemos otra!'),
        ),
      ],
    );
  }
}
