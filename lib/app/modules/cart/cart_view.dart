import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cart_bloc.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: const Color(0xFF527cff),
        centerTitle: true,
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (state is CartError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        }

        if (state is CartLoaded) {
          return ListView.builder(
              padding: const EdgeInsets.only(
                  bottom: 50, top: 15, left: 15, right: 15),
              physics: const BouncingScrollPhysics(),
              itemCount: state.cartProducts.length,
              itemBuilder: (context, index) {
                final currentProduct = state.cartProducts[index];
                return Container(
                  height: 110,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(3, 3),
                        blurRadius: 4,
                      ),
                      BoxShadow(
                        color: Colors.grey.shade100,
                        offset: const Offset(-1, -1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: double.infinity,
                        width: 110,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          // color: Colors.blue.shade200,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: FadeInImage.assetNetwork(
                          image: currentProduct.featuredImage,
                          placeholder: "assets/product-placeholder.png",
                          imageErrorBuilder: (context, error, stackTrace) =>
                              Image.asset("assets/product-placeholder.png"),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(currentProduct.title ?? "",
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 16)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Price",
                                      style: TextStyle(fontSize: 12)),
                                  Text("\$${currentProduct.price}",
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: const [
                              //     Text("Quantity",
                              //         style: TextStyle(fontSize: 12)),
                              //     Text("1", style: TextStyle(fontSize: 12)),
                              //   ],
                              // ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                      style: ButtonStyle(
                                        fixedSize: MaterialStateProperty.all(
                                            const Size(30, 25)),
                                        visualDensity: VisualDensity.compact,
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                      ),
                                      onPressed: () {
                                        context.read<CartBloc>().add(
                                            CartItemRemoved(currentProduct));
                                      },
                                      child: const Icon(
                                        Icons.delete_sharp,
                                        color: Colors.white,
                                        size: 15,
                                      )))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        }
        return const SizedBox();
      }),
      bottomSheet: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            final totalAmount = state.cartProducts.isEmpty
                ? 0
                : state.cartProducts
                    .map((e) => e.price)
                    .reduce((a, b) => a + b);
            return ColoredBox(
              color: Colors.blue.shade200,
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Items : ${state.cartProducts.length}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700)),
                      Text("Grand Total : $totalAmount",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700)),
                    ],
                  ),
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
