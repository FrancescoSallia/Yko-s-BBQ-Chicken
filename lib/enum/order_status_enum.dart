enum OrderStatusEnum { recieved, inProgress, onWay, delivered }

extension OrderLabelText on OrderStatusEnum {
  String get labelText {
    switch (this) {
      case OrderStatusEnum.recieved:
        return "Bestellung ist eingegangen";
      case OrderStatusEnum.inProgress:
        return "Wird Zubereitet";
      case OrderStatusEnum.onWay:
        return "Unterwegs zu dir";
      case OrderStatusEnum.delivered:
        return "Geliefert";
    }
  }

  int get statusIndex {
    switch (this) {
      case OrderStatusEnum.recieved:
        return 0;
      case OrderStatusEnum.inProgress:
        return 1;
      case OrderStatusEnum.onWay:
        return 2;
      case OrderStatusEnum.delivered:
        return 3;
    }
  }
}
