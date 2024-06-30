import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/common/widgets/loaders/animation_loader.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';
import 'package:tstore_app/utils/popups/loader.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color: THelperFunctions.isDarkMode(Get.context!)
                  ? TColors.dark
                  : TColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 250,
                  ), // adjust spacing as needed

                  TAnimationLoaderWidget(text: text, animation: animation),

                  // ElevatedButton(onPressed: () {}, child: Text('click me'))
                ],
              ),
            )));
  }

  //stop the currently open loading dialog
  //method doesnt return anything
  static void stopLoading() {
    if (Navigator.of(Get.overlayContext!).canPop()) {
      Navigator.of(Get.overlayContext!).pop();
    } else {
      TLoaders.successSnackBar(title: 'didnt close', message: 'didnt close');
    }
  }
  // static stopLoading() {
  //   Navigator.of(Get.overlayContext!).pop();
  // }
}
