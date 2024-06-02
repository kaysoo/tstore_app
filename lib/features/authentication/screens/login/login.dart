import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/common/styles/spacing_styles.dart';
import 'package:tstore_app/common/widgets/form_divider.dart';
import 'package:tstore_app/common/widgets/social_buttons.dart';
import 'package:tstore_app/features/authentication/screens/login/components/login_form.dart';
import 'package:tstore_app/features/authentication/screens/login/components/login_header.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: TSpacingStyle.paddingWithAppBarHeight,
      child: Column(
        children: [
          //logo and title with subtitle
          LoginHeader(dark: dark),
          //form
          const LoginForm(),

          //divider
          FormDivider(
            dark: dark,
            dividerText: 'Or Sign in with'.capitalize!,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          //footer
          const SocialButtons()
        ],
      ),
    )));
  }
}
