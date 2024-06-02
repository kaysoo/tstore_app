import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/bottom_navigation.dart';
import 'package:tstore_app/features/authentication/screens/password/forgot_password.dart';
import 'package:tstore_app/features/authentication/screens/signup/sign_up.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
      child: Column(
        children: [
          //email
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right), labelText: "E-mail"),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          //password
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: "Password",
                suffixIcon: Icon(Iconsax.eye_slash)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          //Remember me and forgot Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //remember me
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  const Text("Remember Me")
                ],
              ),
              //forgot password
              TextButton(
                  onPressed: () => Get.to(() => const ForgotPassword()),
                  child: const Text("Forgot password?"))
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // sign in button
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const BottomNavigation()),
                  child: const Text('Sign In'))),

          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          //create account button
          SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () => Get.to(() => const SignUpScreen()),
                  child: const Text('Create Account'))),
        ],
      ),
    ));
  }
}
