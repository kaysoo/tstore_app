import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/features/authentication/screens/signup/components/termsandconditions.dart';
import 'package:tstore_app/features/authentication/screens/signup/verify_email.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                expands: false,
                decoration: const InputDecoration(
                    labelText: "First Name", prefixIcon: Icon(Iconsax.user)),
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwInputFields,
            ),
            Expanded(
              child: TextFormField(
                expands: false,
                decoration: const InputDecoration(
                    labelText: "Last Name", prefixIcon: Icon(Iconsax.user)),
              ),
            ),
          ],
        ),

        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),

        //username
        TextFormField(
          expands: false,
          decoration: const InputDecoration(
              labelText: "Username", prefixIcon: Icon(Iconsax.user_edit)),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),

        //email
        TextFormField(
          expands: false,
          decoration: const InputDecoration(
              labelText: "E-mail", prefixIcon: Icon(Iconsax.direct)),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),

        //phone number
        TextFormField(
          expands: false,
          decoration: const InputDecoration(
              labelText: "Phone Number", prefixIcon: Icon(Iconsax.call)),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),

        //password
        TextFormField(
          expands: false,
          decoration: const InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash)),
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        //terms and conditions

        TermsAndConditions(dark: dark),

        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        // sign up button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.to(() => const VerifyEmailScreen()),
            child: const Text("Create Account"),
          ),
        )
      ],
    ));
  }
}
