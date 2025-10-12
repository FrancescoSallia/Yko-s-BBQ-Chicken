import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:ykos_bbq_chicken/model/adress.dart';
import 'package:ykos_bbq_chicken/model/order_summary.dart';
import 'package:ykos_bbq_chicken/model/payment.dart';

class Order {
  // final User currentUser;
  final String orderId;
  final TimeOfDay currentTime;
  final DateTime currentDate;
  final bool isDelivery;
  final Adress? deliveryAdress;
  final TimeOfDay? selectedTime;
  final DateTime? selectedDate;
  final Payment payment;
  final OrderSummary orderSummary;

  Order({
    String? orderId,
    TimeOfDay? currentTime,
    DateTime? currentDate,
    required this.isDelivery,
    required this.deliveryAdress,
    required this.selectedTime,
    required this.selectedDate,
    required this.payment,
    required this.orderSummary,
  }) : orderId = Uuid().v4(),
       currentTime = TimeOfDay.now(),
       currentDate =
           DateTime.now(); // wenn keine orderId oder aktuelle zeit eingegeben wird, denn wird eins generiert!
}
