import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/vertical_product_shimmer.dart';
import 'package:tstore_app/common/widgets/products_cart/sortable_products.dart';
import 'package:tstore_app/features/shop/controllers/product/all_products_controller.dart';
import 'package:tstore_app/features/shop/models/product_model.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(title),
        shoeBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductByQuery(query),
              builder: (context, snapshot) {
                //check the state of the futurebuilder snapshot
                const loader = TVerticalProductShimmer();
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loader;
                }

                if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No Data Found...'),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong...'),
                  );
                }

                //products found
                final products = snapshot.data!;
                return TSortableProducts(
                  products: products,
                );
              }),
        ),
      ),
    );
  }
}
