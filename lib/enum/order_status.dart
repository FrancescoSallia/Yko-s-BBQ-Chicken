enum OrderStatusEnum { recieved, inProgress, onWay, delivered }

extension OrderLabelText on OrderStatusEnum {
  String get labelText {
    switch (this) {
      case OrderStatusEnum.recieved:
        return "Bestellung eingegangen";
      case OrderStatusEnum.inProgress:
        return "Wird Zubereitet";
      case OrderStatusEnum.onWay:
        return "Unterwegs zu dir";
      case OrderStatusEnum.delivered:
        return "Geliefert";
    }
  }
}
