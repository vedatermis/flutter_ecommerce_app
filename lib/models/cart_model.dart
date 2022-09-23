import 'package:ecommerce_app/models/product_model.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final List<Product> products;

  const Cart({this.products = const <Product>[]});

  Map productQuantity(product) {
    var quantity = {};

    for (var product in products) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    }

    return quantity;
  }

  double get subTotal => products.fold(0, (previousValue, element) => previousValue + element.price);

  double deliveryFee(subTotal) {
    if (subTotal >= 30.0) {
      return 0.0;
    } else {
      return 10.0;
    }
  }

  double total(subtotal, deliveryFee) {
    return subTotal + deliveryFee(subtotal);
  }

  String freeDelivery(subTotal) {
    if (subTotal >= 30.0) {
      return 'You have Free Delivery';
    } else {
      double missing = 30.0 - subTotal;
      return 'Add \$${missing.toStringAsFixed(2)} for FREE delivery';
    }
  }

  String get subtotalString => subTotal.toStringAsFixed(2);
  String get totalString => total(subTotal, deliveryFee).toStringAsFixed(2);

  String get deliveryFeeString => deliveryFee(subTotal).toStringAsFixed(2);
  String get freeDeliveryString => freeDelivery(subTotal);

  @override
  List<Object?> get props => [products];
}
