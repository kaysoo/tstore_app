import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/form_divider.dart';
import 'package:tstore_app/common/widgets/social_buttons.dart';
import 'package:tstore_app/features/authentication/screens/signup/components/signupform.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Text(
                "Let's create your account",
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              //form
              SignUpForm(dark: dark),

              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              //divider
              FormDivider(dark: dark, dividerText: "Or Sign up with"),

              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // social buttons

              const SocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
