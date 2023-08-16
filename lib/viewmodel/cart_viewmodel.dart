import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:venturo_app/model/menu.dart';
import 'package:venturo_app/model/order.dart';

class CartViewModel extends ChangeNotifier {
  Menu? _fetchedMenu;

  int _itemCount = 0;
  int get itemCount => _itemCount;

  Map<int, String> _notes = {};
  Map<int, String> get notes => _notes;

  int _priceCount = 0;
  int get priceCount => _priceCount;

  Map<int, int> _itemsCart = {};
  Map<int, int> get itemsCart => _itemsCart;

  updateMenu(Menu? fetchedMenu) {
    _fetchedMenu = fetchedMenu;
  }

  addNote(int index, String note) {
    _notes[index] = note;
  }

  addItemCount() {
    _itemCount = _itemCount + 1;
    notifyListeners();
  }

  removeItemCount() {
    _itemCount = _itemCount - 1;
    notifyListeners();
  }

  addPriceCount(int itemId, int price) {
    _priceCount = priceCount + price;
    _itemsCart[itemId] = (_itemsCart[itemId] ?? 0) + 1;
    notifyListeners();
  }

  removePriceCount(int itemId, int price) {
    _priceCount = priceCount - price;
    _itemsCart[itemId] = (_itemsCart[itemId] ?? 0) - 1;
    notifyListeners();
  }

  Future sendOrder(int? voucherId, int discount, int total) async {
    final List<Items> listItem = [];
    _itemsCart.forEach((key, value) {
      listItem.add(Items(
        id: key,
        catatan: _notes[key] ?? "",
        harga: _fetchedMenu?.datas?.firstWhere((element) => element.id == key).harga,
      ));
    });

    final response = await http.post(
      Uri.parse("https://tes-mobile.landa.id/api/order"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        Order(
          voucherId: voucherId,
          nominalDiskon: discount,
          nominalPesanan: total,
          items: listItem,
        ),
      ),
    );

    // SELALU GAGAL SAAT POST
    debugPrint(response.body);
  }

  clearCart() {
    _itemCount = 0;
    _priceCount = 0;
    _notes = {};
    _itemsCart = {};
  }
}
