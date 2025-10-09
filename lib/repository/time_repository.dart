import 'package:flutter/material.dart';

class TimeRepository {
  final int openingHour;
  final int closingHour;
  final int closingMinute;
  final int stepMinutes;
  final int minLeadMinutes; // 🔹 Mindestvorlaufzeit in Minuten

  TimeRepository({
    this.openingHour = 12, //öffnungszeiten
    this.closingHour = 22,
    this.closingMinute = 30,
    this.stepMinutes = 10, //10 schritte
    this.minLeadMinutes = 40, // 🔹 z. B. 40 Minuten Vorlaufzeit
  });

  /// Generiert verfügbare Lieferzeiten für ein bestimmtes Datum.
  /// Wenn das Datum heute ist, werden vergangene Zeiten und Zeiten
  /// vor der Mindestvorlaufzeit herausgefiltert.
  List<TimeOfDay> generateAvailableTimes({DateTime? date}) {
    List<TimeOfDay> times = [];
    int startMinutes = openingHour * 60;
    int endMinutes =
        closingHour * 60 +
        closingMinute; // da man 22:30 uhr schließt werden + 30 min (closingMinute) angehängt

    final now = DateTime.now();
    // 🔹 aktuelle Uhrzeit in Minuten + Vorlaufzeit
    final cutoffMinutes = (now.hour * 60 + now.minute) + minLeadMinutes;

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
        if (minutes <= cutoffMinutes) continue;
      }

      times.add(time);
    }

    return times;
  }

  /// 🔹 Formatiert ein Datum als Text (z. B. 09.10.2025)
  Text dateDayMonthYearToString(DateTime? selectedDateFromPicker) {
    return Text(
      "${selectedDateFromPicker?.day.toString() ?? ""}.${selectedDateFromPicker?.month.toString() ?? ""}.${selectedDateFromPicker?.year.toString() ?? ""}",
    );
  }

  /// 🔹 Formatiert die Uhrzeit als Text mit "Uhr" am Ende
  Text timeToString(TimeOfDay? selectedTimeFromPicker, BuildContext context) {
    return Text("${selectedTimeFromPicker?.format(context) ?? ""} Uhr");
  }
}
