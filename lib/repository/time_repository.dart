import 'package:flutter/material.dart';

class TimeRepository {
  final int openingHour;
  final int closingHour;
  final int closingMinute;
  final int stepMinutes;

  TimeRepository({
    this.openingHour = 12, //öffnungszeiten
    this.closingHour = 22,
    this.closingMinute = 30,
    this.stepMinutes = 10, //10 schritte
  });

  /// Generiert verfügbare Lieferzeiten für ein bestimmtes Datum.
  /// Wenn das Datum heute ist, werden vergangene Zeiten herausgefiltert.
  List<TimeOfDay> generateAvailableTimes({DateTime? date}) {
    List<TimeOfDay> times = [];
    int startMinutes = openingHour * 60;
    int endMinutes =
        closingHour * 60 +
        closingMinute; // da man 22:30 uhr schließt werden + 30 min (closingMinute) angehängt

    final now = DateTime.now();

    for (
      int minutes = startMinutes;
      minutes <= endMinutes;
      minutes += stepMinutes
    ) {
      int hour = minutes ~/ 60;
      int minute = minutes % 60;
      final time = TimeOfDay(hour: hour, minute: minute);

      // ⏰ Falls das Datum heute ist, vergangene Zeiten überspringen
      if (date != null &&
          date.day == now.day &&
          date.month == now.month &&
          date.year == now.year) {
        final currentMinutes = now.hour * 60 + now.minute;
        if (minutes <= currentMinutes) continue;
      }

      times.add(time);
    }

    return times;
  }

  Text dateDayMonthYearToString(DateTime? selectedDateFromPicker) {
    return Text(
      "${selectedDateFromPicker?.day.toString() ?? ""}.${selectedDateFromPicker?.month.toString() ?? ""}.${selectedDateFromPicker?.year.toString() ?? ""}",
    );
  }

  Text timeToString(TimeOfDay? selectedTimeFromPicker, BuildContext context) {
    return Text("${selectedTimeFromPicker?.format(context) ?? ""} Uhr");
  }
}
