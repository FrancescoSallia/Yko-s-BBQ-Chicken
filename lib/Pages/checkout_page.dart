import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/Pages/Sheet/sheet_pay.dart';
import 'package:ykos_bbq_chicken/Pages/adress_page.dart';
import 'package:ykos_bbq_chicken/components/delivery_time_container.dart';
import 'package:ykos_bbq_chicken/components/forward_box.dart';
import 'package:ykos_bbq_chicken/components/order_item.dart';
import 'package:ykos_bbq_chicken/components/summary_box.dart';
import 'package:ykos_bbq_chicken/extension/my_extensions.dart';
import 'package:ykos_bbq_chicken/model/adress.dart';
import 'package:ykos_bbq_chicken/model/payment.dart';
import 'package:ykos_bbq_chicken/repository/time_repository.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_menu.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isDeliverySelected = true;
  TimeOfDay? selectedTimeFromPicker;
  DateTime? selectedDateFromPicker;
  int? selectedDeliveryIndex = 0;
  final TimeRepository timeRepo = TimeRepository();
  Payment? selectedPayment;
  Adress? selectedAdress;

  final int closingHour = 22; // Betrieb schließt um 22 Uhr
  final List<int> closedDays = [DateTime.monday]; // Montag geschlossen

  Future<bool> showDateTimePicker(BuildContext context) async {
    final today = DateTime.now();
    final List<DateTime> availableDates =
        List.generate(365, (index) {
          return today.add(Duration(days: index));
        }).where((date) => !closedDays.contains(date.weekday)).toList();

    int selectedDateIndex = 0;
    int selectedTimeIndex = 0;

    timeRepo.generateAvailableTimes();

    List<TimeOfDay> times = timeRepo.generateAvailableTimes(
      date: availableDates[selectedDateIndex],
    );

    final bool? confirmed = await showModalBottomSheet(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
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
                              // Dynamische Aktualisierung der Zeiten bei Datumsauswahl
                              times = timeRepo.generateAvailableTimes(
                                date: availableDates[selectedDateIndex],
                              );
                              selectedTimeIndex = 0;
                              setModalState(() {});
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
                                  final weekday =
                                      weekdayNames[date.weekday - 1];
                                  final day = date.day.toString().padLeft(
                                    2,
                                    '0',
                                  );
                                  final month = date.month.toString().padLeft(
                                    2,
                                    '0',
                                  );
                                  return Center(
                                    child: Text("$weekday,  $day.$month"),
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
                        Navigator.pop(
                          context,
                          true,
                        ); // <— returne true, wenn Nutzer bestätigt
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
      },
    );
    return confirmed ?? false;
  }

  @override
  void initState() {
    final viewModelMenu = context.read<ViewmodelMenu>();
    viewModelMenu.loadCartList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModelMenu = context.watch<ViewmodelMenu>();
    final cartItems = viewModelMenu.cartList;
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Checkout",
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Toggle container
            toogleButton(),
            SizedBox(height: 20),

            //Box to Navigato to adress or something else
            GestureDetector(
              onTap: () async {
                final adress = await Navigator.of(
                  context,
                ).push(CupertinoPageRoute(builder: (context) => AdressPage()));

                if (adress != null) {
                  setState(() {
                    selectedAdress = adress;
                  });
                }
              },
              child: ForwardBox(
                title:
                    selectedAdress != null
                        ? selectedAdress!.name
                        : "Lieferadresse",
                announcementText:
                    selectedAdress != null
                        ? "${selectedAdress!.street} ${selectedAdress!.houseNumber}, ${selectedAdress!.plz} ${selectedAdress!.place}"
                        : "Zum Fortfahren hier tippen",
                iconData: Icons.location_on_outlined,
                img: null,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Lieferzeit",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                DeliveryTimeContainer(
                  index: 0,
                  title: "So schnell wie möglich",
                  subTitle: "ca. 40-60 Min.",
                  isSelected: selectedDeliveryIndex == 0,
                  gesture: () {
                    setState(() {
                      selectedDeliveryIndex = 0;
                    });
                  },
                ),
                DeliveryTimeContainer(
                  index: 1,
                  title: "Lieferzeit wählen",
                  subTitle:
                      selectedDateFromPicker == null ||
                              selectedTimeFromPicker == null
                          ? "Keine Zeit gewählt"
                          : selectedDateFromPicker?.day == DateTime.now().day
                          ? "Heute ${timeRepo.timeToString(selectedTimeFromPicker, context).data}"
                          : "${timeRepo.dateDayMonthYearToString(selectedDateFromPicker).data} um ${timeRepo.timeToString(selectedTimeFromPicker, context).data}",
                  isSelected: selectedDeliveryIndex == 1,
                  gesture: () async {
                    final confirmed = await showDateTimePicker(context);

                    setState(() {
                      if (confirmed &&
                          selectedDateFromPicker != null &&
                          selectedTimeFromPicker != null) {
                        selectedDeliveryIndex =
                            1; // Nutzer hat bestätigt → Lieferzeit ausgewählt
                      } else {
                        selectedDeliveryIndex =
                            0; // Nutzer hat Picker geschlossen → zurück zu Standard
                      }
                    });
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Zahlung",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final payment = await showModalBottomSheet<Payment>(
                      showDragHandle: true,
                      backgroundColor: Colors.white,
                      context: context,
                      builder:
                          (context) =>
                              SheetPay(selectedPayment: selectedPayment),
                    );

                    if (payment != null) {
                      setState(() {
                        selectedPayment = payment;
                      });
                    }
                  },
                  child: ForwardBox(
                    title: "Zahlungsmöglichkeit",
                    announcementText:
                        selectedPayment?.name ??
                        "Wähle eine Zahlungsmöglichkeit aus",
                    iconData:
                        selectedPayment != null
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                    img: selectedPayment?.img,
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bestellung",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final cartitem = cartItems[index];
                        return OrderItem(orderItem: cartitem);
                      },
                    ),
                  ),
                ),

                SummaryBox(),
                SizedBox(height: 100),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: WidgetStatePropertyAll(3),
              backgroundColor: WidgetStatePropertyAll(AppColors.timerPrimary2),
              foregroundColor: WidgetStatePropertyAll(AppColors.primaryButton),
            ),
            onPressed: () {},
            child: Text("Kostenpflichtig Bestellen"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
