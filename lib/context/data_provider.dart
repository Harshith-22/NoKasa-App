import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  // final List<Map<String, dynamic>> cart = [];
  final List<String> trashItems = [];
  final List<dynamic> savedAddressList = [];
  double latitude = 0;
  double logitude = 0;
  String selectedAddress = 'Add Address';
  String selectedSlot = "Select";
  String homeAddress = "Add Address";
  void addHomeAddress(String address) {
    homeAddress = address;
    notifyListeners();
  }

  void addAddress(String address) {
    selectedAddress = address;
    notifyListeners();
  }

  void selectSlot(String slot) {
    selectedSlot = slot;
    notifyListeners();
  }

  void addToAddressList(dynamic address) {
    savedAddressList.add(address);
    notifyListeners();
  }

  void removeFromAddressList(dynamic address) {
    savedAddressList.remove(address);
    notifyListeners();
  }
}
