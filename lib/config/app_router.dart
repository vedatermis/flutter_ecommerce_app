import 'package:ecommerce_app/screens/screens.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return HomeScreen.route();

      case '/splash':
        return SplashScreen.route();

      case CartScreen.routeName:
        return CartScreen.route();

      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);

      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);

      case WishlistScreen.routeName:
        return WishlistScreen.route();

      case CheckoutScreen.routeName:
        return CheckoutScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
      ),
    );
  }
}
