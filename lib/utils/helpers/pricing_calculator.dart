class TPricingCalculator {
  //calculate price based on tax and shipping
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);
    double totalPrice = productPrice + taxAmount + shippingCost;

    return totalPrice;
  }

  //shipping cost calculation
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  //calculate tax
  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    //get appropriate tax rate from api and use
    return 0.10;
  }

  static double getShippingCost(String location) {
    //fetch appropriate shipping cost
    return 5.00;
  }

  // sum all cart values and return total amount
  // static double calculateCartTotal(CartModel cart){
  //   return cart.items.map((e)=>e.price).fold(0,(previousPrice,currentPrice)=>previousPrice + (currentPrice ?? 0));
  // }
}
