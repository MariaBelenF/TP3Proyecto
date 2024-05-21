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
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _events = {};
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
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
