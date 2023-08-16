import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:venturo_app/model/voucher.dart';

class VoucherViewModel with ChangeNotifier {
  Datas? _savedVoucher;
  Datas? get savedVoucher => _savedVoucher;

  Future<Voucher> getVoucher(String kodeVoucher) async {
    final response = await http.get(
      Uri.parse("https://tes-mobile.landa.id/api/vouchers?kode=$kodeVoucher"),
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      final data = Voucher.fromJson(jsonDecode(response.body));
      if (data.statusCode == 200) {
        _savedVoucher = data.datas;
      }
      notifyListeners();
      return data;
    } else {
      throw Exception("Failed");
    }
  }
}
