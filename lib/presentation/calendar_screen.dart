import 'package:cine_practica/core/entities/User.dart';
import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:cine_practica/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cine_practica/presentation/bottom_navigation_bar.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

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
      _routineDays =
          List<int>.generate(loggedUser.currentRoutine!.duration, (i) => i + 1);
      _exerciseDays = loggedUser.currentRoutine!.daysDone.toSet();

      // Ordenar los días en daysDone
      loggedUser.currentRoutine!.daysDone.sort((a, b) => a.compareTo(b));
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
        if (isDayDone) {
          texto =
              'Este día (${selectedDay.day}/${selectedDay.month}) entrenaste! Deseas eliminar el registro?';
        } else {
          texto = '¿Entrenaste el ${selectedDay.day}/${selectedDay.month}?';
        }
        return AlertDialog(
          title: Text('Confirmar entrenamiento'),
          content: Text(texto),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (!isDayDone) {
                    loggedUser.currentRoutine!.addDayDone(selectedDay);
                  } else {
                    loggedUser.currentRoutine!.removeDayDone(selectedDay);
                  }
                  // Ordenar los días en daysDone después de modificar
                  loggedUser.currentRoutine!.daysDone
                      .sort((a, b) => a.compareTo(b));
                });
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

  // Función para construir el calendario
  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2022, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) =>
          loggedUser.currentRoutine!.daysDone.contains(day),
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
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
                Text(
                'Historial de entrenamiento',
                style: TextStyle(fontSize: 25),
              ),
                IconButton(
                onPressed: _informationDialog,
                icon: Icon(Icons.help_outlined),
          ),
            ],
          ),
          
          _buildCalendar(),
          Text(
            'Entrenamientos realizados',
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: loggedUser.currentRoutine!.daysDone.length,
              itemBuilder: (context, index) {
                DateTime day = loggedUser.currentRoutine!.daysDone[index];
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
