import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/common/widgets/success_screen/success_screen.dart';
import 'package:tstore_app/data/repositories/repositories_authentication/authentication_repository.dart';
import 'package:tstore_app/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:tstore_app/features/authentication/screens/login/login.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRespository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Image
              Image(
                  image: const AssetImage(TImages.deliveredEmail),
                  width: THelperFunctions.screenWidth() * 0.6),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              //title & subtitle
              Text(
                "Verify your email address",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                "Congratulations Your Account Awaits. Verify Your Email to Start Shopping and Experience a World of Unlimited Deals and Personalized Offers.",
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.checkEmailVerificationStatus(),
                  // onPressed: () {},
                  child: const Text("Continue"),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => controller.sendEmailVerification(),
                  // onPressed: () {},
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
