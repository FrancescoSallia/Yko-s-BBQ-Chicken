import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/Pages/Sheet/sheet_pay.dart';
import 'package:ykos_bbq_chicken/Pages/Sheet/sheet_pick_up.dart';
import 'package:ykos_bbq_chicken/Pages/Ordering/adress_page.dart';
import 'package:ykos_bbq_chicken/Pages/Timer/order_pending_page.dart';
import 'package:ykos_bbq_chicken/components/delivery_time_container.dart';
import 'package:ykos_bbq_chicken/components/forward_box.dart';
import 'package:ykos_bbq_chicken/components/order_item.dart';
import 'package:ykos_bbq_chicken/components/summary_box.dart';
import 'package:ykos_bbq_chicken/model/adress.dart';
import 'package:ykos_bbq_chicken/model/order.dart';
import 'package:ykos_bbq_chicken/model/payment.dart';
import 'package:ykos_bbq_chicken/repository/time_repository.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_fire_auth.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_user.dart';
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
  int? selectedDeliveryIndex;
  final TimeRepository timeRepo = TimeRepository();
  Payment? selectedPayment;
  Adress? selectedAdress;
  // final TextEditingController _discountController = TextEditingController();

  final List<int> closedDays = [DateTime.monday]; // Montag geschlossen

  bool get isRestaurantOpen {
    final now = TimeOfDay.now();
    final today = DateTime.now();
    final isClosedDay = closedDays.contains(today.weekday);

    final isBeforeOpening = now.hour < timeRepo.openingHour;
    final isAfterClosing =
        now.hour > timeRepo.closingHour ||
        (now.hour == timeRepo.closingHour && now.minute > 0);

    return !(isClosedDay || isBeforeOpening || isAfterClosing);
  }

  Future<bool> showDateTimePicker(BuildContext context) async {
    final today = DateTime.now();
    final List<DateTime> availableDates =
        List.generate(365, (index) {
          return today.add(Duration(days: index));
        }).where((date) => !closedDays.contains(date.weekday)).toList();

    int selectedDateIndex = 0;
    int selectedTimeIndex = 0;

    // timeRepo.generateAvailableTimes();

    List<TimeOfDay> times = timeRepo.generateAvailableTimes(
      date: availableDates[selectedDateIndex],
    );

    final bool? confirmed = await showModalBottomSheet(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SizedBox(
              height: 350,
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
                            itemExtent: 45,
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
                            itemExtent: 45,
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModelMenu = context.read<ViewmodelMenu>();
      // final viewModelAuth = context.read<ViewmodelFireAuth>();
      if (closedDays.contains(DateTime.now().weekday)) {
        selectedDeliveryIndex = null;
      } else {
        selectedDeliveryIndex = 0;
      }
      viewModelMenu.loadCartList();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (viewModelMenu.error != null) {
          AnimatedSnackBar.material(
            viewModelMenu.error.toString(),
            type: AnimatedSnackBarType.error,
          ).show(context);
          viewModelMenu.clearError();
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModelMenu = context.watch<ViewmodelMenu>();
    final viewModelUser = context.watch<ViewmodelUser>();
    final viewModelAuth = context.watch<ViewmodelFireAuth>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModelMenu.error != null) {
        AnimatedSnackBar.material(
          viewModelMenu.error.toString(),
          type: AnimatedSnackBarType.error,
        ).show(context);
        viewModelMenu.clearError();
      }
    });

    final canPlaceOrder =
        viewModelMenu.itsFilledOut(
          selectedAdress,
          selectedPayment,
          isDeliverySelected,
          selectedTimeFromPicker,
          selectedDateFromPicker,
          viewModelUser.pickUpUser,
          selectedDeliveryIndex,
        ) &&
        (
        // Restaurant ist geöffnet
        isRestaurantOpen
            // oder es ist eine zukünftige Zeit ausgewählt (Vorbestellung)
            ||
            (selectedDateFromPicker != null && selectedTimeFromPicker != null));

    final cartItems = viewModelMenu.cartList;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "KASSE",
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
              onTap:
                  isDeliverySelected
                      ? () async {
                        final adress = await Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => AdressPage(),
                          ),
                        );

                        if (adress != null) {
                          setState(() {
                            selectedAdress = adress;
                          });
                        }
                      }
                      : () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          backgroundColor: AppColors.secondary,
                          isDismissible: true,
                          showDragHandle: true,
                          builder: (context) {
                            return SheetPickUp();
                          },
                        );
                      },
              child: ForwardBox(
                title:
                    isDeliverySelected
                        ? selectedAdress != null
                            ? selectedAdress!.name
                            : "Lieferadresse"
                        : viewModelUser.pickUpUser != null
                        ? "${viewModelUser.pickUpUser!.name} ${viewModelUser.pickUpUser!.lastName}"
                        : "Abholer/in",
                announcementText:
                    isDeliverySelected
                        ? selectedAdress != null
                            ? "${selectedAdress!.street} ${selectedAdress!.houseNumber}, ${selectedAdress!.plz} ${selectedAdress!.place}"
                            : "Zum Fortfahren hier tippen"
                        : viewModelUser.pickUpUser != null
                        ? viewModelUser.pickUpUser!.telefon
                        : "zu Personenbezogenen Daten",
                iconData:
                    isDeliverySelected
                        ? selectedAdress != null
                            ? Icons.check_circle_rounded
                            : Icons.location_on_outlined
                        : viewModelUser.pickUpUser != null
                        ? Icons.shopping_bag
                        : Icons.shopping_bag_outlined,
                img: null,
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        isDeliverySelected ? "Lieferzeit" : "Abholzeit",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible:
                      closedDays.contains(DateTime.now().weekday) ||
                      TimeOfDay.now().hour < timeRepo.openingHour ||
                      TimeOfDay.now().hour >= timeRepo.closingHour,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10,
                    ),
                    child: Text(
                      "Das Restaurant ist zu jetzigem Zeitpunkt geschlossen",
                      style: GoogleFonts.inter(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Visibility(
                  visible:
                      isDeliverySelected &&
                      !closedDays.contains(DateTime.now().weekday) &&
                      TimeOfDay.now().hour >= timeRepo.openingHour &&
                      TimeOfDay.now().hour < timeRepo.closingHour,
                  child: DeliveryTimeContainer(
                    index: 0,
                    title: "So schnell wie möglich",
                    subTitle: "ca. 40-60 Min.",
                    isSelected: selectedDeliveryIndex == 0,
                    gesture: () {
                      setState(() {
                        selectedDeliveryIndex = 0;
                        selectedDateFromPicker = null;
                        selectedTimeFromPicker = null;
                      });
                    },
                  ),
                ),
                DeliveryTimeContainer(
                  index: 1,
                  title:
                      isDeliverySelected
                          ? "Lieferzeit wählen"
                          : "Abholzeit wählen",
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
                SizedBox(height: 25),

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

                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 10.0,
                //     vertical: 10,
                //   ),
                //   child: MyTextfield(
                //     controller: _discountController,
                //     hintText: "GUTSCHEIN CODE HIER:",
                //     obscure: false,
                //     icon: Icons.card_giftcard,
                //   ),
                // ),
                // TextButton(
                //   //TODO: Gutschein generator erstellen, um Gutscheine zu erstellen die man hier eingeben kann!
                //   onPressed: () {
                //     setState(() {
                //       // Erlaubt die Eingabe von Prozentzahlen wie 20 und wandelt sie in 0.20 um
                //       final input = _discountController.text.replaceAll(
                //         ',',
                //         '.',
                //       );
                //       final value = double.tryParse(input);
                //       if (value != null) {
                //         viewModelMenu.currentDiscount = value / 100.0;
                //       } else {
                //         viewModelMenu.currentDiscount = null;
                //       }
                //     });
                //   },
                //   child: Text("Gutschein Einlösen"),
                // ),
                SummaryBox(
                  orderSummary: viewModelMenu.orderSummeryBox(
                    isDeliverySelected,
                  ),
                ),
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
              elevation:
                  canPlaceOrder
                      ? const WidgetStatePropertyAll(3)
                      : const WidgetStatePropertyAll(0),
              backgroundColor:
                  canPlaceOrder
                      ? const WidgetStatePropertyAll(AppColors.timerPrimary2)
                      : WidgetStatePropertyAll(
                        Colors.black.withValues(alpha: 0.2),
                      ),
              foregroundColor:
                  canPlaceOrder
                      ? const WidgetStatePropertyAll(AppColors.primaryButton)
                      : const WidgetStatePropertyAll(Colors.white),
            ),
            onPressed:
                canPlaceOrder
                    ? () async {
                      // Berechne Fast-Delivery-Zeit, falls "so schnell wie möglich"
                      TimeOfDay? fastTime;

                      if (selectedDeliveryIndex == 0 && isDeliverySelected) {
                        final now = DateTime.now().add(
                          const Duration(minutes: 40),
                        );
                        fastTime = TimeOfDay.fromDateTime(now);
                      }

                      final newOrder = Order(
                        pickUpUser: viewModelUser.pickUpUser,
                        userId: viewModelAuth.currentUser!.uid.toString(),
                        isDelivery: isDeliverySelected,
                        deliveryAdress: selectedAdress,
                        fastDeliveryTime: fastTime,
                        selectedTime: selectedTimeFromPicker,
                        selectedDate: selectedDateFromPicker,
                        payment: selectedPayment!,
                        orderSummary: viewModelMenu.orderSummeryBox(
                          isDeliverySelected,
                        ),
                      );
                      final navigator = Navigator.of(context);
                      await viewModelMenu.addToOrderList(newOrder);
                      if (!mounted) return;
                      viewModelMenu.clearAnyList(viewModelMenu.cartList);

                      navigator.pushReplacement(
                        CupertinoPageRoute(
                          builder:
                              (context) => OrderPendingPage(newOrder: newOrder),
                        ),
                      );
                    }
                    : null,
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
                  _buildToggleButton("Lieferung", true),
                  _buildToggleButton("Abholung", false),
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
