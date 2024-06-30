import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/features/authentication/controllers/forgot_password/forgot_password_controller.dart';
import 'package:tstore_app/features/authentication/screens/login/login.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Image(
                  image: const AssetImage(TImages.deliveredEmail),
                  width: THelperFunctions.screenWidth() * 0.6),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              //title & subtitle
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              //title & subtitle
              Text(
                "Password Reset Email Sent to your email",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              Text(
                "Your Account Security is Our Priority. We've Sent You a Secure Link to Safely Change Your Password and Keep Your Account Protected.",
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => const LoginScreen()),
                  child: const Text("Done"),
                ),
              ),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              //button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => ForgotPasswordController.instance
                      .resendPasswordResetEmail(email),
                  child: const Text("Resend Email"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
