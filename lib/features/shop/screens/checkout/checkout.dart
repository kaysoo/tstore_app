import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/bottom_navigation.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/containers/rounded_container.dart';
import 'package:tstore_app/common/widgets/products_cart/coupon_widget.dart';
import 'package:tstore_app/common/widgets/success_screen/success_screen.dart';
import 'package:tstore_app/features/shop/controllers/cart_controller.dart';
import 'package:tstore_app/features/shop/controllers/product/order_controller.dart';
import 'package:tstore_app/features/shop/screens/cart/components/cart_items_listview.dart';
import 'package:tstore_app/features/shop/screens/checkout/components/billing_address_section.dart';
import 'package:tstore_app/features/shop/screens/checkout/components/billing_amount_section.dart';
import 'package:tstore_app/features/shop/screens/checkout/components/billing_payment_section.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';
import 'package:tstore_app/utils/helpers/pricing_calculator.dart';
import 'package:tstore_app/utils/popups/loader.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = TPricingCalculator.calculateTotalPrice(subTotal, 'GH');

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        shoeBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// items in the cart
              const TCartItems(
                showaddremovebuttons: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //coupon textfield
              const TCouponCode(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //billing section
              RoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    //pricing
                    TBillingAmountSection(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    //divider
                    Divider(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    //payment methods
                    TBillingPaymentSection(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    //Address
                    TBillingAddressSection()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalAmount)
              : () => TLoaders.warningSnackBar(
                  title: 'Empty Cart',
                  message: 'Add items to the cart in order to proceed.'),
          child: Text("Checkout \$$totalAmount"),
        ),
      ),
    );
  }
}
