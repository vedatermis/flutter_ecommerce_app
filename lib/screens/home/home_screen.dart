import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/blocs/category/category_bloc.dart';
import 'package:ecommerce_app/blocs/product/product_bloc.dart';
import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is CategoryLoaded) {
                return CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  items: state.categories.map((category) => HeroCarouselCard(category: category)).toList(),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          const SectionTitle(title: 'RECOMMENDED'),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProductLoaded) {
                return ProductCarousel(products: state.products.where((product) => product.isRecommended).toList());
              } else {
                return const SizedBox();
              }
            },
          ),
          const SectionTitle(title: 'MOST POPULAR'),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProductLoaded) {
                return ProductCarousel(products: state.products.where((product) => product.isPopular).toList());
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
