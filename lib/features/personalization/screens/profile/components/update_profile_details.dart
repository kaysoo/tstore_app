import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/features/personalization/controllers/update_details_controller.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/validators/validation.dart';

class UpdateProfileDetails extends StatelessWidget {
  const UpdateProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      //custom appbar
      appBar: CustomAppBar(
        shoeBackArrow: true,
        title: Text(
          'Change Profile Details',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //heading
            Text(
              'Kindly ensure all details entered is valid as any detail changed will appear on several pages',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            //text fields and save button
            Form(
                child: Column(
              children: [
                TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      TValidator.validateEmptyText('First name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: 'First Name', prefixIcon: Icon(Iconsax.user)),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      TValidator.validateEmptyText('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: 'Last Name', prefixIcon: Icon(Iconsax.user)),
                ),
              ],
            )),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            // save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserName(),
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
