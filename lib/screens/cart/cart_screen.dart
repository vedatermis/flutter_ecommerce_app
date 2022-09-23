import 'package:ecommerce_app/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

  static Route route() {
    return MaterialPageRoute(settings: const RouteSettings(name: routeName), builder: (_) => const CartScreen());
  }

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Cart'),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    'GO TO CHECKOUT',
                    style: Theme.of(context).textTheme.headline3,
                  ))
            ],
          ),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CartLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 0,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.cart.freeDeliveryString,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: const RoundedRectangleBorder(), elevation: 0),
                                  child: Text('Add More Items', style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)))
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ListView.builder(
                          itemCount: state.cart.productQuantity(state.cart.products).keys.length,
                          itemBuilder: (context, index) {
                            return CartProductCard(
                                product: state.cart.productQuantity(state.cart.products).keys.elementAt(index),
                                quantity: state.cart.productQuantity(state.cart.products).values.elementAt(index));
                          }),
                    ),
                    Expanded(
                      flex: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Divider(thickness: 2),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('SUBTOTAL', style: Theme.of(context).textTheme.headline5),
                                    Text('\$${state.cart.subtotalString}', style: Theme.of(context).textTheme.headline5),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('DELIVERY FEE', style: Theme.of(context).textTheme.headline5),
                                    Text('\$${state.cart.deliveryFeeString}', style: Theme.of(context).textTheme.headline5),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                decoration: BoxDecoration(color: Colors.black.withAlpha(50)),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.all(5.0),
                                height: 50,
                                decoration: const BoxDecoration(color: Colors.black),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('TOTAL', style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)),
                                      Text('\$${state.cart.totalString}',
                                          style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
