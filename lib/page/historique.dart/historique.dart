import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
class HistoriquePage extends StatefulWidget {
  final List<String> messagesToMove;

  HistoriquePage({required this.messagesToMove});

  @override
  _HistoriquePageState createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _firstDay = DateTime.utc(2023, 1, 1);
  DateTime _lastDay = DateTime.utc(2023, 12, 31);

  List<String> getMessagesForSelectedDay(DateTime selectedDay) {
    return widget.messagesToMove.where((message) {
      int separatorIndex = message.lastIndexOf(" - ");
      if (separatorIndex != -1) {
        String timestamp = message.substring(separatorIndex + 3);
        DateTime messageDay = DateTime.parse(timestamp);
        return isSameDay(messageDay, selectedDay);
      }
      return false;
    }).toList();
  }
 
  @override
  Widget build(BuildContext context) {
    List<String> selectedDayMessages = getMessagesForSelectedDay(_selectedDay);

    return Scaffold(
      appBar: AppBar(
        title: Text("Historique"),
      ),
      body: Column(
        children: [
          TableCalendar(
            calendarFormat: _calendarFormat,
            focusedDay: _selectedDay,
            firstDay: _firstDay,
            lastDay: _lastDay,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onDaySelected: (selectedDay, _) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: selectedDayMessages.length,
              itemBuilder: (context, index) {
                String message = selectedDayMessages[index];
                int separatorIndex = message.lastIndexOf(" - ");
                if (separatorIndex == -1) {
                  // La séparation n'a pas été trouvée, afficher un message d'erreur
                  return ListTile(
                    title: Text("Erreur de format du message"),
                  );
                }
                String text = message.substring(0, separatorIndex);
                String timestamp = message.substring(separatorIndex + 3);
                return ListTile(
                  title: Text(text),
                  subtitle: Text(timestamp),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
