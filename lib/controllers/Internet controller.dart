import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetCheckController extends GetxController {
  late bool internet;
  bool internetCheckLoader = true;

  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void onInit() {
    checkInternetStatus().then((value) {
      internet = value;
      internetCheckLoader = false;
      update();
      internetStatusChange();
    });
    super.onInit();
  }

  Future<bool> checkInternetStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network.
      return true;
    } else {
      // I am not connected network.
      return false;
    }
  }

  void internetStatusChange() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!

      print("object");

      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        internet = true;
        update();
        print("change: $internet");
      } else {
        // I am not connected network.
        internet = false;
        update();
        print("change: $internet");
      }
    });
  }
}
