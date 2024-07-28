import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:tstore_app/bottom_navigation.dart';
import 'package:tstore_app/common/widgets/success_screen/success_screen.dart';
import 'package:tstore_app/data/repositories/order/order_repository.dart';
import 'package:tstore_app/data/repositories/repositories_authentication/authentication_repository.dart';
import 'package:tstore_app/features/personalization/controllers/address_controller.dart';
import 'package:tstore_app/features/shop/controllers/cart_controller.dart';
import 'package:tstore_app/features/shop/controllers/checkout_controller.dart';
import 'package:tstore_app/features/shop/models/order_model.dart';
import 'package:tstore_app/utils/constants/enums.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/popups/full_screen_loader.dart';
import 'package:tstore_app/utils/popups/loader.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  //variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  //fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchAllUserOrders();
      return userOrders;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  //add methods for order processing
  void processOrder(double totalAmount) async {
    try {
      //start loader
      TFullScreenLoader.openLoadingDialog('Processing your order',
          'https://lottie.host/7353556f-a444-4c02-a872-a3555273d683/1px2tjRHKI.json');

      //get user authentication id
      final userId = AuthenticationRespository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      //add details
      final order = OrderModel(
          id: UniqueKey().toString(),
          userId: userId,
          status: OrderStatus.pending,
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
          paymentMethod: checkoutController.selectedPaymentMethod.value.name,
          address: addressController.selectedAddress.value,
          deliveryDate: DateTime.now(),
          items: cartController.cartItems.toList());

      //save order to firestore
      await orderRepository.saveOrder(order, userId);

      //update cart status
      cartController.clearCart();

      //show success screen
      Get.off(() => SuccessScreen(
          image: TImages.paymentSuccess,
          title: 'Payment Success!',
          subtitle: 'Your item will be shipped soon!',
          onPressed: () => Get.offAll(() => const BottomNavigation())));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      // return [];
    }
  }
}
