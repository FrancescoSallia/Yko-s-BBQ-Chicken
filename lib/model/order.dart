import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ykos_bbq_chicken/enum/order_status_enum.dart';
import 'package:ykos_bbq_chicken/model/adress.dart';
import 'package:ykos_bbq_chicken/model/order_summary.dart';
import 'package:ykos_bbq_chicken/model/payment.dart';
import 'package:ykos_bbq_chicken/model/user.dart';

class Order {
  final User? pickUpUser;
  final String userId;
  final String orderId;
  final TimeOfDay currentTime;
  final DateTime currentDate;
  final bool isDelivery;
  final Adress? deliveryAdress;
  final TimeOfDay? fastDeliveryTime;
  final TimeOfDay? selectedTime;
  final DateTime? selectedDate;
  final Payment payment;
  final OrderSummary orderSummary;
  final OrderStatusEnum orderStatus;
  final bool confirmedByKitchen;

  Order({
    required this.pickUpUser,
    required this.userId,
    String? orderId,
    TimeOfDay? currentTime,
    DateTime? currentDate,
    OrderStatusEnum? orderStatus,
    required this.isDelivery,
    required this.deliveryAdress,
    required this.fastDeliveryTime,
    required this.selectedTime,
    required this.selectedDate,
    required this.payment,
    required this.orderSummary,
    this.confirmedByKitchen = false,
  }) : orderId = orderId ?? const Uuid().v4(),
       currentTime = currentTime ?? TimeOfDay.now(),
       currentDate = currentDate ?? DateTime.now(),
       orderStatus = orderStatus ?? OrderStatusEnum.recieved;

  Map<String, dynamic> toJson() {
    return {
      "pickUpUser": pickUpUser?.toJson(),
      "userId": userId,
      "orderId": orderId,
      "currentTime": {"hour": currentTime.hour, "minute": currentTime.minute},
      "currentDate": Timestamp.fromDate(currentDate),
      "isDelivery": isDelivery,
      "deliveryAdress": deliveryAdress?.toJson(),
      "fastDeliveryTime":
          fastDeliveryTime != null
              ? {
                "hour": fastDeliveryTime!.hour,
                "minute": fastDeliveryTime!.minute,
              }
              : null,
      "selectedTime":
          selectedTime != null
              ? {"hour": selectedTime!.hour, "minute": selectedTime!.minute}
              : null,
      "selectedDate":
          selectedDate != null ? Timestamp.fromDate(selectedDate!) : null,
      "payment": payment.toJson(),
      "orderSummary": orderSummary.toJson(),
      "orderStatus": orderStatus.name,
      "confirmedByKitchen": confirmedByKitchen,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      pickUpUser:
          json["pickUpUser"] != null ? User.fromJson(json["pickUpUser"]) : null,
      userId: json["userId"],
      orderId: json["orderId"],
      currentTime:
          json["currentTime"] != null
              ? TimeOfDay(
                hour: json["currentTime"]["hour"],
                minute: json["currentTime"]["minute"],
              )
              : TimeOfDay.now(),
      currentDate: (json["currentDate"] as Timestamp).toDate(),
      isDelivery: json["isDelivery"] ?? false,
      deliveryAdress:
          json["deliveryAdress"] != null
              ? Adress.fromJson(json["deliveryAdress"])
              : null,
      fastDeliveryTime:
          json["fastDeliveryTime"] != null
              ? TimeOfDay(
                hour: json["fastDeliveryTime"]["hour"],
                minute: json["fastDeliveryTime"]["minute"],
              )
              : null,
      selectedTime:
          json["selectedTime"] != null
              ? TimeOfDay(
                hour: json["selectedTime"]["hour"],
                minute: json["selectedTime"]["minute"],
              )
              : null,
      selectedDate:
          json["selectedDate"] != null
              ? (json["selectedDate"] as Timestamp).toDate()
              : null,
      payment: Payment.fromJson(json["payment"]),
      orderSummary: OrderSummary.fromJson(json["orderSummary"]),
      orderStatus: OrderStatusEnum.values.firstWhere(
        (e) => e.name == json["orderStatus"],
        orElse: () => OrderStatusEnum.recieved,
      ),
      confirmedByKitchen: json["confirmedByKitchen"] ?? false,
    );
  }
}
