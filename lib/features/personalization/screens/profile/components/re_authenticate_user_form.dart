import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/features/personalization/controllers/user_controller.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/validators/validation.dart';

class ReAuthenticatLoginForm extends StatelessWidget {
  const ReAuthenticatLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Re-Authenticate User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: (value) => TValidator.validateEmail(value),
                  decoration: const InputDecoration(
                      labelText: 'E-mail',
                      prefixIcon: Icon(Iconsax.direct_right)),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                //password
                Obx(
                  () => TextFormField(
                    obscureText: controller.hidePassword.value,
                    controller: controller.verifyPassword,
                    validator: (value) => TValidator.validatePassword(value),
                    decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Iconsax.password_check),
                        suffixIcon: IconButton(
                            onPressed: () => controller.hidePassword.value =
                                !controller.hidePassword.value,
                            icon: const Icon(Iconsax.eye_slash))),
                  ),
                ),

                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                //verify button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        controller.reAuthenticateEmailandPasswordUser(),
                    child: const Text('Verify'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
