import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

class Network {
  static Future<bool> isConnected() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (![ConnectivityResult.mobile, ConnectivityResult.wifi]
          .contains(connectivityResult)) {
        return false;
      }
      return true;
    } on PlatformException catch (e, stacktrace) {
      print('Couldn\'t check connectivity status: ${e.toString()}');
      print('Couldn\'t check connectivity status: ${stacktrace.toString()}');
      return false;
    }
  }
}
