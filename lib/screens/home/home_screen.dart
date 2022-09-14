import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(settings: const RouteSettings(name: routeName), builder: (_) => const HomeScreen());
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Zero To Unicorn'),
      bottomNavigationBar: const CustomNavBar(),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 2.0,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            items: Category.categories.map((category) => HeroCarouselCard(category: category)).toList(),
          ),
          const SectionTitle(title: 'RECOMMENDED'),
          ProductCarousel(products: Product.products.where((product) => product.isRecommended).toList()),
          const SectionTitle(title: 'MOST POPULAR'),
          ProductCarousel(products: Product.products.where((product) => product.isPopular).toList())
        ],
      ),
    );
  }
}
