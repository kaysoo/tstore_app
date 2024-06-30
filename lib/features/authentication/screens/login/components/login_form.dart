import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/bottom_navigation.dart';
import 'package:tstore_app/features/authentication/controllers/login/login_controller.dart';
import 'package:tstore_app/features/authentication/screens/password/forgot_password.dart';
import 'package:tstore_app/features/authentication/screens/signup/sign_up.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/validators/validation.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
        key: controller.loginFormKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
          child: Column(
            children: [
              //email
              TextFormField(
                controller: controller.email,
                validator: (value) => TValidator.validateEmail(value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: "E-mail"),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              //password
              Obx(
                () => TextFormField(
                  controller: controller.password,
                  obscureText: controller.hidePassword.value,
                  validator: (value) =>
                      TValidator.validateEmptyText('Password', value),
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
                height: TSizes.spaceBtwInputFields,
              ),
              //Remember me and forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //remember me
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: (value) => controller.rememberMe.value =
                                !controller.rememberMe.value),
                      ),
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
                      onPressed: () => controller.emailAndPasswordSignIn(),
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
