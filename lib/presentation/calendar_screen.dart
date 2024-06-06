import 'package:cine_practica/core/entities/Calendar.dart';
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
  late List<int> _routineDays = [];
  late Set<DateTime> _exerciseDays;
  late Usuario loggedUser;
  Calendar negocio = Calendar();

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
    if (negocio.isRoutineFinished()) {
      Future.delayed(Duration.zero, () {
        _showCustomDialog(context);
      });
    }

    if (manager.getRoutine() != null) {
      _routineDays = manager.getRutineDays();
      _exerciseDays = manager.getExerciseDays();
      manager.ordenarLista();
    }
  }

  void _showConfirmationDialog(DateTime selectedDay) {
    bool isDayDone = negocio.isDayDone(selectedDay);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(negocio.getDialogContent()),
          content: Text(negocio.isRoutineFinished()
              ? 'Ya finalizaste esta rutina. Dirígete hacia Rutinas para comenzar otra'
              : negocio.getDialogTitle(selectedDay)),
          actions: negocio.isRoutineFinished()
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
                        if (isDayDone) {
                          loggedUser.timesDone.removeWhere((day) => isSameDay(day, selectedDay));
                        } else {
                          loggedUser.timesDone.add(selectedDay);
                        }
                        manager.ordenarLista();
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
      selectedDayPredicate: (day) => loggedUser.timesDone.any((d) => isSameDay(d, day)),
      onDaySelected: (selectedDay, focusedDay) {
        _showConfirmationDialog(selectedDay);
      },
    );
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
      },
    );
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
                itemCount: manager.getExerciseDays().length,
                itemBuilder: (context, index) {
                  DateTime day = loggedUser.timesDone[index];
                  String dayName = negocio.getDayName(day.weekday);
                  String monthName = negocio.getMonthName(day.month);
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
