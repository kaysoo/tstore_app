import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tstore_app/app.dart';
import 'package:tstore_app/data/repositories/repositories_authentication/authentication_repository.dart';
import 'package:tstore_app/firebase_options.dart';

Future<void> main() async {
  //widgets binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  //local storage ---- getx storage
  await GetStorage.init();

  // await native splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRespository()));

  runApp(const App());
}
