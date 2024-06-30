import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/features/authentication/controllers/signup/signup_controller.dart';
import 'package:tstore_app/features/authentication/screens/signup/components/termsandconditions.dart';
import 'package:tstore_app/features/authentication/screens/signup/verify_email.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/validators/validation.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        TValidator.validateEmptyText('First name', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: "First Name",
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwInputFields,
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        TValidator.validateEmptyText('Last name', value),
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
              controller: controller.userName,
              validator: (value) =>
                  TValidator.validateEmptyText('Username', value),
              expands: false,
              decoration: const InputDecoration(
                  labelText: "Username", prefixIcon: Icon(Iconsax.user_edit)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            //email
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              expands: false,
              decoration: const InputDecoration(
                  labelText: "E-mail", prefixIcon: Icon(Iconsax.direct)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            //phone number
            TextFormField(
              controller: controller.phoneNumber,
              validator: (value) => TValidator.validatePhoneNumber(value),
              expands: false,
              decoration: const InputDecoration(
                  labelText: "Phone Number", prefixIcon: Icon(Iconsax.call)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            //password
            Obx(
              () => TextFormField(
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                validator: (value) => TValidator.validatePassword(value),
                expands: false,
                decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye))),
              ),
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
                onPressed: () => controller.signup(),
                // onPressed: () => Get.to(() => const VerifyEmailScreen()),
                child: const Text("Create Account"),
              ),
            )
          ],
        ));
  }
}
