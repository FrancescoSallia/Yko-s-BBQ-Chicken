import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:ykos_bbq_chicken/enum/order_status_enum.dart';
import 'package:ykos_bbq_chicken/model/adress.dart';
import 'package:ykos_bbq_chicken/model/order_summary.dart';
import 'package:ykos_bbq_chicken/model/payment.dart';
import 'package:ykos_bbq_chicken/model/user.dart';

class Order {
  final User? pickUpUser;
  final String orderId;
  final TimeOfDay currentTime;
  final DateTime currentDate;
  final bool isDelivery;
  final Adress? deliveryAdress;
  final TimeOfDay? selectedTime;
  final DateTime? selectedDate;
  final Payment payment;
  final OrderSummary orderSummary;
  final OrderStatusEnum orderStatus;

  Order({
    required this.pickUpUser,
    String? orderId,
    TimeOfDay? currentTime,
    DateTime? currentDate,
    OrderStatusEnum? orderStatus,
    required this.isDelivery,
    required this.deliveryAdress,
    required this.selectedTime,
    required this.selectedDate,
    required this.payment,
    required this.orderSummary,
  }) : orderId = Uuid().v4(),
       currentTime = TimeOfDay.now(),
       currentDate = DateTime.now(),
       orderStatus =
           OrderStatusEnum
               .recieved; // wenn keine orderId oder aktuelle zeit eingegeben wird, denn wird eins generiert!
}
