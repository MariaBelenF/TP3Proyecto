// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:cine_practica/presentation/custom_alert_dialog.dart';
import 'package:cine_practica/presentation/profile_screen.dart';
import 'package:cine_practica/presentation/routines_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cine_practica/presentation/bottom_navigation_bar.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import '../core/entities/UserManager.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);
  static const String name = 'CalendarScreen';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  UserManager manager = UserManager();
  late String routineTitle;
  late List<int> _routineDays;
  late Set<DateTime> _exerciseDays;
  late Usuario loggedUser;
  
void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog();
      },
    );
  }
  @override
  void initState() {
    super.initState();
    loggedUser = manager.getLoggedUser()!;
    if (loggedUser.timesDone.length == loggedUser.getRoutine()!.duration) {
      Future.delayed(Duration.zero, () {
        _showCustomDialog(context);
      });
    }
    
    if (loggedUser != null && loggedUser.currentRoutine != null) {
      routineTitle = loggedUser.currentRoutine!.title;
      _routineDays =
          List<int>.generate(loggedUser.currentRoutine!.duration, (i) => i + 1);
      _exerciseDays = loggedUser.timesDone.toSet();

      // Ordenar los días en daysDone
      loggedUser.timesDone.sort((a, b) => a.compareTo(b));
    } else {
      routineTitle = 'No hay rutina asignada';
      _routineDays = [];
    }
  }

  

  // Función para mostrar el diálogo al hacer clic en un día del calendario
  void _showConfirmationDialog(DateTime selectedDay) {
    bool isDayDone = loggedUser.timesDone.contains(selectedDay);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String texto = '';
        if (isDayDone) {
          texto =
              'Este día (${selectedDay.day}/${selectedDay.month}) entrenaste! Deseas eliminar el registro?';
        } else {
          texto = '¿Entrenaste el ${selectedDay.day}/${selectedDay.month}?';
        }
        return AlertDialog(
          title: Text(
              loggedUser.timesDone.length == loggedUser.getRoutine()!.duration
                  ? 'Rutina Completada'
                  : 'Confirmar entrenamiento'),
          content: Text(loggedUser.timesDone.length ==
                  loggedUser.getRoutine()!.duration
              ? 'Ya finalizaste esta rutina. Dirígete hacia Rutinas para comenzar otra'
              : texto),
          actions:
              loggedUser.timesDone.length == loggedUser.getRoutine()!.duration
                  ? [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context.pushNamed(RoutinesScreen.name);
                        },
                        child: Text('¡Vamos!'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                      ),
                    ]
                  : [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (!isDayDone) {
                              loggedUser.addDayDone(selectedDay);
                            } else {
                              loggedUser.removeDayDone(selectedDay);
                            }
                            loggedUser.timesDone.sort((a, b) => a.compareTo(b));
                          });
                          manager.updateLoggedUser();
                          Navigator.pop(context);
                        },
                        child: Text('Sí'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                      ),
                    ],
        );
      },
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2022, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) => loggedUser.timesDone.contains(day),
      onDaySelected: (selectedDay, focusedDay) {
        _showConfirmationDialog(selectedDay);
      },
    );
  }

  String _getMonthName(int month) {
    String es_month = "";
    switch (month) {
      case 1:
        es_month = "Enero";
        break;
      case 2:
        es_month = "Febrero";
        break;
      case 3:
        es_month = "Marzo";
        break;
      case 4:
        es_month = "Abril";
        break;
      case 5:
        es_month = "Mayo";
        break;
      case 6:
        es_month = "Junio";
        break;
      case 7:
        es_month = "Julio";
        break;
      case 8:
        es_month = "Agosto";
        break;
      case 9:
        es_month = "Septiembre";
        break;
      case 10:
        es_month = "Octubre";
        break;
      case 11:
        es_month = "Noviembre";
        break;
      case 12:
        es_month = "Diciembre";
        break;
    }
    return es_month;
  }

  String _getDayName(int day) {
    String es_day = "";
    switch (day) {
      case 1:
        es_day = "Lunes";
        break;
      case 2:
        es_day = "Martes";
        break;
      case 3:
        es_day = "Miércoles";
        break;
      case 4:
        es_day = "Jueves";
        break;
      case 5:
        es_day = "Viernes";
        break;
      case 6:
        es_day = "Sábado";
        break;
      case 7:
        es_day = "Domingo";
        break;
    }
    return es_day;
  }

  void _informationDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'En esta sección vas a poder registrar todos tus entrenamientos en la fecha en la que los realizas clickeando el día en el calendario, para así mantener un registro de tu entrenamiento, progreso y compromiso')
              ],
            ),
          );
        });
  }
 

  @override
 
     Widget build(BuildContext context) {
   
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 1),
      appBar: AppBar(
        title: Text('Progreso'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              context.pushNamed(ProfileScreen.name);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(1.0, 15, 1, 18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.white.withOpacity(0.4),
                  ),
                  padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Historial',
                        style: TextStyle(fontSize: 20),
                      ),
                      IconButton(
                        onPressed: _informationDialog,
                        icon: Icon(Icons.help_outlined),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _buildCalendar(),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Colors.white.withOpacity(0.4),
              ),
              padding: EdgeInsets.all(5),
              child: Text(
                'Sesiones de entrenamiento',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: loggedUser.timesDone.length,
                itemBuilder: (context, index) {
                  DateTime day = loggedUser.timesDone[index];
                  String dayName = _getDayName(day.weekday);
                  String monthName = _getMonthName(day.month);
                  return ListTile(
                    title: Text('$dayName, ${day.day} de $monthName'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

