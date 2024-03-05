import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class InternetChecker {
  Future<bool> hasInternet() async {
    try {
      if (kIsWeb) {
        final response = await get(
          Uri.parse('google.com'),
        );
        return response.statusCode == 200;
      } else {
        final list = await InternetAddress.lookup('google.com');
        if (list.isNotEmpty && list.first.rawAddress.isNotEmpty) {
          return true;
        }
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
