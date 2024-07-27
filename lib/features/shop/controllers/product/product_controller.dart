import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:tstore_app/data/repositories/products/product_repository.dart';
import 'package:tstore_app/features/shop/models/brand_model.dart';
import 'package:tstore_app/features/shop/models/product_attribute_model.dart';
import 'package:tstore_app/features/shop/models/product_model.dart';
import 'package:tstore_app/utils/constants/enums.dart';
import 'package:tstore_app/utils/popups/loader.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  // Map<ProductModel> details = <ProductModel>{};
  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      //show loader
      isLoading.value = true;

      //fetch products
      final products = await productRepository.getFeaturedProducts();

      //assign products
      featuredProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      //fetch products
      final products = await productRepository.getAllFeaturedProducts();
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
      return [];
    }
  }

  //get product price or price range for variations
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    //if no variations exist return simple price or sale price
    if (product.productType == ProductType.single.name) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      //calculate the smallest and largets prices among variations
      for (var variation in product.productVariations!) {
        double pricetoConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        //update smallest and largest prices
        if (pricetoConsider < smallestPrice) {
          smallestPrice = pricetoConsider;
        }
        if (pricetoConsider > largestPrice) {
          largestPrice = pricetoConsider;
        }
      }

      //if smallest and largest price are the same return a single price
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        //otherwise return a price range
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  // calculate discount percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) {
      return '0';
    }
    if (originalPrice <= 0) {
      return '0';
    }
    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  // check product stock status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  static final List<ProductModel> details = [
    ProductModel(
        id: '2',
        price: 0.0,
        productType: '',
        stock: 1,
        thumbnail: '',
        title: '',
        brand: BrandModel(id: '', image: '', name: ''),
        categoryId: '',
        // date: '' as DateTime,
        description: '',
        images: [],
        isFeatured: true,
        // productAttributes: ProductAttributeModel(name: '',),
        // productVariations: [],
        salePrice: 0.0,
        sku: '')
  ];

  //send product details to firebase db
  void sendFeaturedProducts() async {
    try {
      //show loader
      isLoading.value = true;

      //get products model

      final brandDetails = <String, dynamic>{
        'Id': '5',
        'Image':
            'hhttps://firebasestorage.googleapis.com/v0/b/ecommerceapp-bca0e.appspot.com/o/Users%2FImages%2Fbrands%2Fzara_logo.png?alt=media&token=38ad50af-6449-42cd-ab83-40de1d95dd78',
        'IsFeatured': true,
        'Name': 'Zara',
        'ProductCount': 320
      };

      final details = <String, dynamic>{
        // 'id': '2',
        'Price': 120.0,
        'ProductType': 'single',
        'Stock': 47,
        'Thumbnail':
            'https://firebasestorage.googleapis.com/v0/b/ecommerceapp-bca0e.appspot.com/o/Users%2FImages%2FProducts%2Fadidas_shoe3.jpeg?alt=media&token=4c42504e-5ede-4208-b811-0c8705e9156a',
        'Title': 'Adidas Drop Step',
        'Brand': {
          'Id': '2',
          'Image':
              'https://firebasestorage.googleapis.com/v0/b/ecommerceapp-bca0e.appspot.com/o/Users%2FImages%2FProducts%2Fadidas.png?alt=media&token=cc4989e2-55d3-496d-b974-889b0a7e7cc1',
          'Name': 'Adidas',
          'IsFeatured': true,
          'ProductsCount': 125
        },
        'CategoryId': '2',
        // date: '' as DateTime,
        'Description':
            'Best adidas shoes available for comfort and fashion. Feel at your best whenever you step out.',
        'Images': [
          'https://firebasestorage.googleapis.com/v0/b/ecommerceapp-bca0e.appspot.com/o/Users%2FImages%2FProducts%2Fadidas_shoe1.jpeg?alt=media&token=d4449aa2-85ed-423d-8d4d-3787c878841c',
          'https://firebasestorage.googleapis.com/v0/b/ecommerceapp-bca0e.appspot.com/o/Users%2FImages%2FProducts%2Fadidas_shoe2.jpeg?alt=media&token=3fb74ef5-e231-4c46-ac24-f371b38d5ef2',
          'https://firebasestorage.googleapis.com/v0/b/ecommerceapp-bca0e.appspot.com/o/Users%2FImages%2FProducts%2Fadidas_shoe3.jpeg?alt=media&token=4c42504e-5ede-4208-b811-0c8705e9156a'
        ],
        'IsFeatured': true,
        'ProductAttributes': [
          {
            'Name': 'Color',
            'Values': ['White', 'Blue']
          }
        ],
        'ProductVariations': [
          {
            'AttributeValues': {'Color': 'Blue', 'Size': 'EU 43'}
          }
        ],
        'SalePrice': 100.0,
        'SKU': ''
      };

      final details1 = <String, dynamic>{
        // 'id': '2',
        'Price': 70.0,
        'ProductType': 'single',
        'Stock': 35,
        'Thumbnail':
            'https://firebasestorage.googleapis.com/v0/b/ecommerceapp-bca0e.appspot.com/o/Users%2FImages%2FProducts%2Fpolo_shirt2.jpeg?alt=media&token=191f3ecb-edfe-4c00-bc81-76604e0575bf',
        'Title': 'Round Neck shirts',
        'Brand': {
          'Id': '3',
          'Image':
              'https://firebasestorage.googleapis.com/v0/b/ecommerceapp-bca0e.appspot.com/o/Users%2FImages%2FProducts%2Fpolo_logo.png?alt=media&token=43b0be3d-1c08-4b14-bec8-59819fa96500',
          'Name': 'Polo',
          'IsFeatured': true,
          'ProductsCount': 25
        },
        'CategoryId': '3',
        // date: '' as DateTime,
        'Description': 'Various round neck shirts available for purchases.',
        'Images': [
          'https://firebasestorage.googleapis.com/v0/b/ecommerceapp-bca0e.appspot.com/o/Users%2FImages%2FProducts%2Fpolo_shirt1.jpeg?alt=media&token=685bc1bd-94df-4e82-b80d-2fd4b6beaf5e',
          'https://firebasestorage.googleapis.com/v0/b/ecommerceapp-bca0e.appspot.com/o/Users%2FImages%2FProducts%2Fpolo_shirt2.jpeg?alt=media&token=191f3ecb-edfe-4c00-bc81-76604e0575bf',
          'https://firebasestorage.googleapis.com/v0/b/ecommerceapp-bca0e.appspot.com/o/Users%2FImages%2FProducts%2Fpolo_shirt3.jpeg?alt=media&token=7f73457f-5455-4637-8af7-393406d36100'
        ],
        'IsFeatured': true,
        'ProductAttributes': [
          {
            'Name': 'Color',
            'Values': ['White', 'Blue']
          }
        ],
        'ProductVariations': [
          {
            'AttributeValues': {'Color': 'Blue', 'Size': 'EU 43'}
          }
        ],
        'SalePrice': 40.0,
        'SKU': ''
      };

      final details2 = <String, dynamic>{
        // 'id': '2',
        'Price': 40.0,
        'ProductType': 'single',
        'Stock': 25,
        'Thumbnail':
            'https://firebasestorage.googleapis.com/v0/b/ecommerceapp-bca0e.appspot.com/o/Users%2FImages%2FProducts%2Fpolo_shirt2.jpeg?alt=media&token=191f3ecb-edfe-4c00-bc81-76604e0575bf',
        'Title': 'Cargo Pants',
        'Brand': {
          'Id': '4',
          'Image':
              'https://firebasestorage.googleapis.com/v0/b/ecommerceapp-bca0e.appspot.com/o/Users%2FImages%2FProducts%2Fpolo_logo.png?alt=media&token=43b0be3d-1c08-4b14-bec8-59819fa96500',
          'Name': 'Dickies',
          'IsFeatured': true,
          'ProductsCount': 25
        },
        'CategoryId': '4',
        // date: '' as DateTime,
        'Description': 'Quality and affordable pants.',
        'Images': [
          'https://firebasestorage.googleapis.com/v0/b/ecommerceapp-bca0e.appspot.com/o/Users%2FImages%2FProducts%2Fpolo_shirt1.jpeg?alt=media&token=685bc1bd-94df-4e82-b80d-2fd4b6beaf5e',
          'https://firebasestorage.googleapis.com/v0/b/ecommerceapp-bca0e.appspot.com/o/Users%2FImages%2FProducts%2Fpolo_shirt2.jpeg?alt=media&token=191f3ecb-edfe-4c00-bc81-76604e0575bf',
          'https://firebasestorage.googleapis.com/v0/b/ecommerceapp-bca0e.appspot.com/o/Users%2FImages%2FProducts%2Fpolo_shirt3.jpeg?alt=media&token=7f73457f-5455-4637-8af7-393406d36100'
        ],
        'IsFeatured': true,
        'ProductAttributes': [
          {'Name': '', 'Values': []}
        ],
        'ProductVariations': [
          {'AttributeValues': {}}
        ],
        'SalePrice': 0.0,
        'SKU': ''
      };

      ////// -------dummy payload for products upload
      //    final details1 = <String, dynamic>{
      //   // 'id': '2',
      //   'price': 70.0,
      //   'productType': 'single',
      //   'stock': 35,
      //   'thumbnail':'',
      //   'title': '',
      //   'brand': {
      //     'Id': '3',
      //     'Image':
      //         '',
      //     'Name': '',
      //     'IsFeatured': true,
      //     'ProductsCount': 125
      //   },
      //   'categoryId': '2',
      //   // date: '' as DateTime,
      //   'description':
      //       '',
      //   'images': [
      //     '',
      //     '',
      //     ''
      //   ],
      //   'isFeatured': true,
      //   // productAttributes: ProductAttributeModel(name: '',),
      //   // productVariations: [],
      //   'salePrice': 100.0,
      //   'sku': ''
      // };

      // final detailsss <Map<String,dynamic>> ={}

      // ProductModel(id: id, stock: stock, price: price, title: title, thumbnail: thumbnail, productType: productType);
      // BrandModel(id: id, image: image, name: name)

      await FirebaseFirestore.instance.collection('Brands').add(brandDetails);

      // await FirebaseFirestore.instance.collection('Products').add({
      //   // 'id': '2',
      //   'price': 0.0,
      //   'productType': '',
      //   'stock': 1,
      //   'thumbnail': '',
      //   'title': '',
      //   // 'brand': BrandModel(id: '', image: '', name: ''),
      //   'categoryId': '',
      //   // date: '' as DateTime,
      //   'description': '',
      //   'images': [],
      //   'isFeatured': true,
      //   // productAttributes: ProductAttributeModel(name: '',),
      //   // productVariations: [],
      //   'salePrice': 0.0,
      //   'sku': ''
      // });

      //assign products
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
