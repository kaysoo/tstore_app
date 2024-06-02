import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/features/authentication/screens/onboarding/onboarding.dart';
import 'package:tstore_app/utils/theme/theme.dart';

// void main() {
//   runApp(const App());
// }

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const OnboardingScreen(),
    );
  }
}
