import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isDeliverySelected = true;
  bool deliveryTimeContainerIsSelected = false;
  TimeOfDay? selectedTimeFromPicker;
  DateTime? selectedDateFromPicker;

  final int closingHour = 22; // Betrieb schließt um 22 Uhr
  final List<int> closedDays = [DateTime.monday]; // Montag geschlossen

  List<TimeOfDay> generateAvailableTimes({
    int openingHour = 12, // Öffnet um 12:00
    int closingHour = 22, // Schließt um 22:30
    int closingMinute = 30,
    int stepMinutes = 10, // alle 10 Minuten (kannst auf 15 ändern)
  }) {
    List<TimeOfDay> times = [];
    int startMinutes = openingHour * 60; // Startzeit in Minuten
    int endMinutes = closingHour * 60 + closingMinute;

    for (
      int minutes = startMinutes;
      minutes <= endMinutes;
      minutes += stepMinutes
    ) {
      int hour = minutes ~/ 60;
      int minute = minutes % 60;
      times.add(TimeOfDay(hour: hour, minute: minute));
    }

    return times;
  }

  void showDateTimePicker(BuildContext context) {
    final times = generateAvailableTimes(
      openingHour: 12,
      closingHour: 22,
      closingMinute: 30,
      stepMinutes: 10,
    );

    final today = DateTime.now();
    final List<DateTime> availableDates =
        List.generate(365, (index) {
          return today.add(Duration(days: index));
        }).where((date) => !closedDays.contains(date.weekday)).toList();

    int selectedDateIndex = 0;
    int selectedTimeIndex = 0;

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                child: Text(
                  "Datum & Zeit auswählen",
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                          initialItem: selectedDateIndex,
                        ),
                        itemExtent: 32,
                        onSelectedItemChanged: (index) {
                          selectedDateIndex = index;
                        },
                        children:
                            availableDates.map((date) {
                              final weekdayNames = [
                                'Mo',
                                'Di',
                                'Mi',
                                'Do',
                                'Fr',
                                'Sa',
                                'So',
                              ];
                              final weekday = weekdayNames[date.weekday - 1];
                              final day = date.day.toString().padLeft(2, '0');
                              final month = date.month.toString().padLeft(
                                2,
                                '0',
                              );
                              return Center(
                                child: Text("$weekday, $day.$month"),
                              );
                            }).toList(),
                      ),
                    ),
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                          initialItem: selectedTimeIndex,
                        ),
                        itemExtent: 32,
                        onSelectedItemChanged: (index) {
                          selectedTimeIndex = index;
                        },
                        children:
                            times.map((time) {
                              final label =
                                  "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                              return Center(child: Text(label));
                            }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0, top: 10),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedDateFromPicker =
                          availableDates[selectedDateIndex];
                      selectedTimeFromPicker = times[selectedTimeIndex];
                    });
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: AppColors.primary,
                    elevation: 2,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadiusGeometry.circular(6),
                    ),
                  ),
                  child: Text("Bestätigen"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: Text(
          "Checkout",
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // Toggle container
          toogleButton(),
          SizedBox(height: 10),

          //Box to Navigato to adress or something else
          ForwardBox(
            title: "Adresse hinzufügen",
            announcementText: "Zum Fortfahren hier tippen",
            iconData: Icons.location_on_outlined,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Lieferzeit",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              DeliveryTimeContainer(
                title: "Standard",
                subTitle: "50-60 Min.",
                isSelected: deliveryTimeContainerIsSelected,
                gesture: () {
                  setState(() {
                    deliveryTimeContainerIsSelected =
                        !deliveryTimeContainerIsSelected;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(selectedTimeFromPicker?.format(context) ?? ""),
                  Text(selectedDateFromPicker?.day.toString() ?? ""),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => showDateTimePicker(context),
                    child: Text("Datum & Zeit auswählen"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget toogleButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 350,
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondaryButton),
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Colors.black.withValues(alpha: 0.1),
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Animated highlight background
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment:
                    isDeliverySelected
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                child: Container(
                  width: 175,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildToggleButton("Delivery", true),
                  _buildToggleButton("Pick Up", false),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildToggleButton(String text, bool isDeliveryButton) {
    bool isSelected =
        (isDeliveryButton && isDeliverySelected) ||
        (!isDeliveryButton && !isDeliverySelected);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isDeliverySelected = isDeliveryButton;
          });
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isDeliveryButton
                    ? Icons.directions_bike_rounded
                    : Icons.home_filled,
                size: 20,
              ),
              SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeliveryTimeContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isSelected;
  final Function() gesture;
  const DeliveryTimeContainer({
    super.key,
    required this.title,
    required this.subTitle,
    required this.isSelected,
    required this.gesture,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gesture,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color:
                isSelected == true
                    ? AppColors.timerTextPrimary
                    : AppColors.textFieldColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              isSelected == true ? Icons.check_circle : Icons.circle_outlined,
              size: 28,
              color:
                  isSelected == true
                      ? AppColors.timerTextPrimary
                      : AppColors.textFieldColor,
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
                Text(
                  subTitle,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    color: AppColors.textFieldColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ForwardBox extends StatelessWidget {
  final String title;
  final String announcementText;
  final IconData iconData;
  const ForwardBox({
    super.key,
    required this.title,
    required this.announcementText,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(iconData, size: 30),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    announcementText,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textFieldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 20),
        ],
      ),
    );
  }
}
