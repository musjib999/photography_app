import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void clearFormFields(List<TextEditingController> controllers) {
  for (var controller in controllers) {
    controller.clear();
  }
}

List<DropdownMenuItem> getDropdownItems(List items) {
  List<DropdownMenuItem> dropdowmItems = [];

  for (String item in items) {
    var newItem = DropdownMenuItem(child: Text(item), value: item);
    dropdowmItems.add(newItem);
  }
  return dropdowmItems;
}

String formatMoney(int currency) {
  return NumberFormat.simpleCurrency(name: 'NGN').format(currency);
}

String formatNumber(int number) {
  return NumberFormat.decimalPattern('en_us').format(number);
}
