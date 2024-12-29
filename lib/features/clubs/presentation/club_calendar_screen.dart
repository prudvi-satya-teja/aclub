import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';



class ClubCalendarScreen extends StatefulWidget {
  const ClubCalendarScreen({Key? key}) : super(key: key);

  @override
  _ClubCalendarScreenState createState() => _ClubCalendarScreenState();
}

class _ClubCalendarScreenState extends State<ClubCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Calendar'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              // Fetch events for the selected day
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  title: Text('Meeting with members'),
                  subtitle: Text('2:00 PM - 3:00 PM'),
                ),
                ListTile(
                  title: Text('Event planning session'),
                  subtitle: Text('4:00 PM - 5:00 PM'),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add event logic here
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Event'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TextField(
                    decoration: InputDecoration(hintText: 'Enter event title'),
                  ),
                  const SizedBox(height: 8),
                  const TextField(
                    decoration: InputDecoration(hintText: 'Enter event time'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Event added to calendar.')),
                    );
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
