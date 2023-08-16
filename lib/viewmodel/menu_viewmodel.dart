import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:venturo_app/model/menu.dart';

class MenuViewModel with ChangeNotifier {
  Menu? _fetchedMenu;
  Menu? get fetchedMenu => _fetchedMenu;

  Future<Menu> getMenu() async {
    final response = await http.get(
      Uri.parse("https://tes-mobile.landa.id/api/menus"),
    );
    if (response.statusCode == 200) {
      final data = Menu.fromJson(jsonDecode(response.body));
      _fetchedMenu = data;
      return data;
    } else {
      throw Exception("Failed");
    }
  }
}
