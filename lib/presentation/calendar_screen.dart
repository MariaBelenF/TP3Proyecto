import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:cine_practica/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cine_practica/presentation/bottom_navigation_bar.dart';

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

  @override
  void initState() {
    super.initState();
    loggedUser = manager.getLoggedUser()!;
    if (loggedUser != null && loggedUser.currentRoutine != null) {
      routineTitle = loggedUser.currentRoutine!.title;
      _routineDays = List<int>.generate(loggedUser.currentRoutine!.duration, (i) => i + 1);
      _exerciseDays = loggedUser.currentRoutine!.daysDone.toSet();
    } else {
      routineTitle = 'No hay rutina asignada';
      _routineDays = [];
    }
  }
  // Función para mostrar el diálogo al hacer clic en un día del calendario
  void _showConfirmationDialog(DateTime selectedDay) {
    bool isDayDone = loggedUser.currentRoutine!.daysDone.contains(selectedDay);
    showDialog(
      context: context,
      builder: (BuildContext context) {
         String texto = '';
        if(isDayDone){
          texto = 'Este día (${selectedDay.day}/${selectedDay.month}) entrenaste! Deseas eliminar el registro?';
        }else{
           texto = '¿Entrenaste el ${selectedDay.day}/${selectedDay.month}?';
        }
        return AlertDialog(
          title: Text('Confirmar entrenamiento'),
          content: Text(texto),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  String texto = "";
                  if(!isDayDone){
                    loggedUser.currentRoutine!.addDayDone(selectedDay);
                  }
                  else{
                     loggedUser.currentRoutine!.removeDayDone(selectedDay);
                  }
                  
                });
                Navigator.pop(context);
              },
              child: Text('Si'),
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

  // Función para construir el calendario
  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2022, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) => loggedUser.currentRoutine!.daysDone.contains(day),
      onDaySelected: (selectedDay, focusedDay) {
        _showConfirmationDialog(selectedDay);
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Historial de entrenamiento', style: TextStyle( fontSize: 25)),
            _buildCalendar(),
          ],),
      )
    );
  }
}