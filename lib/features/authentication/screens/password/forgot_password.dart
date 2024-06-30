import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/features/authentication/controllers/forgot_password/forgot_password_controller.dart';
import 'package:tstore_app/features/authentication/screens/password/reset_password.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/validators/validation.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //headings
            Text(
              "Forgot Password",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text(
              "Don't worry sometimes people can forget too, just enter your email and we will send you a password reset link",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections * 2,
            ),

            //text field
            Form(
              key: controller.forgotPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: TValidator.validateEmail,
                decoration: const InputDecoration(
                    labelText: "E-Mail",
                    prefixIcon: Icon(Iconsax.direct_right)),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            //submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.sendPasswordResetEmail(),
                child: const Text("Submit"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
