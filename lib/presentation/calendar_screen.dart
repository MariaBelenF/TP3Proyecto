import 'package:cine_practica/core/entities/UserManager.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cine_practica/presentation/bottom_navigation_bar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);
  static const String name = 'CalendarScreen';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<dynamic>> _events;
  late ValueNotifier<List<dynamic>> _selectedEvents;
  UserManager manager = UserManager();
  late DateTime _focusedDay;
  late List<int> _routineDays; // Días de la rutina
  late Set<DateTime> _exerciseDays; // Días de ejercicio
  late String routineTitle; // Título de la rutina

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _events = {};
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
    _exerciseDays = {}; // Inicializar conjunto de días de ejercicio

    // Obtener la rutina del usuario logueado
    final loggedUser = manager.getLoggedUser();
    if (loggedUser != null && loggedUser.currentRoutine != null) {
      routineTitle = loggedUser.currentRoutine!.getTitle(); // Nombre de la rutina
      _routineDays = List<int>.generate(loggedUser.currentRoutine!.duration, (i) => i + 1);
    } else {
      routineTitle = 'No hay rutina asignada';
      _routineDays = [];
    }
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void _toggleExerciseDay(DateTime day) {
    setState(() {
      if (_exerciseDays.contains(day)) {
        _exerciseDays.remove(day);
      } else {
        _exerciseDays.add(day);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 1),
      appBar: AppBar(
        title: Text('Calendario'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // Update focused day
                _selectedEvents.value = _getEventsForDay(selectedDay);
              });
            },
            eventLoader: _getEventsForDay,
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (_exerciseDays.contains(day)) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              routineTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Wrap(
            spacing: 10.0,
            children: _routineDays.map((day) {
              return GestureDetector(
                onTap: () {
                  _toggleExerciseDay(DateTime(
                    _selectedDay.year,
                    _selectedDay.month,
                    day,
                  ));
                },
                child: CircleAvatar(
                  backgroundColor: _exerciseDays.contains(DateTime(
                    _selectedDay.year,
                    _selectedDay.month,
                    day,
                  ))
                      ? Colors.green
                      : Colors.grey,
                  child: Text(
                    day.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }).toList(),
          ),
          Expanded(
            child: ValueListenableBuilder<List<dynamic>>(
              valueListenable: _selectedEvents,
              builder: (context, events, _) {
                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(events[index].toString()),
                      // Add more details if needed
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
