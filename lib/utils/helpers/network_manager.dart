import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tstore_app/utils/popups/loader.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription connsub;
  // final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  //initialize the network manager and set up to continually check the connection status
  @override
  void onInit() {
    super.onInit();

    connsub =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  //update the connection status based on changes in connectivity and show relevant popup for no internet connection
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    // _connectionStatus.value = result;
    if (result.contains(ConnectivityResult.none)) {
      TLoaders.warningSnackBar(
          title: 'No Internet Connection',
          message: "Kindly check your internet services");
    }
  }
  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   _connectionStatus.value = result;
  //   if (_connectionStatus.value == ConnectivityResult.none) {
  //     TLoaders.warningSnackBar(title: 'No Internet Connection');
  //   }
  // }

  //check the internet connection status
  //returns true if connected, 'false' otherwise

  Future<bool> isConnected() async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await _connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.mobile)) {
        // Mobile network available.
        return true;
      } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
        return true;
      } else {
        return false;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

//dispose or close the active connectivity stream
  @override
  void onClose() {
    super.onClose();
    connsub.cancel();
  }
}
