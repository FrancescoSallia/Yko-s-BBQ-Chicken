enum OrderStatus { recieved, inProgress, onWay, delivered }

extension OrderLabelText on OrderStatus {
  String get labelText {
    switch (this) {
      case OrderStatus.recieved:
        return "Bestellung eingegangen";
      case OrderStatus.inProgress:
        return "Wird Zubereitet";
      case OrderStatus.onWay:
        return "Unterwegs zu dir";
      case OrderStatus.delivered:
        return "Geliefert";
    }
  }
}
