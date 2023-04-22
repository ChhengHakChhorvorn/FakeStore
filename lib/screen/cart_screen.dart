import 'package:fake_store/data/response/user_response.dart';
import 'package:fake_store/helper/widget/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../data/bloc/cart_bloc/cart_bloc.dart';
import '../data/response/product_response.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, this.user}) : super(key: key);
  final UserResponse? user;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    final username = widget.user?.id.toString() ?? FirebaseAuth.instance.currentUser?.uid ?? '';
    context.read<CartBloc>().add(GetProductEvent(username: username));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cart',
                  style: TextStyle(fontSize: 35),
                ),
              ],
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartSuccessState) {
                  double total = 0;
                  for (Product item in state.products) {
                    total += item.price! * item.qty!;
                  }
                  return Column(
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            Product product = state.products[index];
                            return Card(
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                leading: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Image.network(product.imageUrl!),
                                ),
                                title: Text(
                                  product.title!,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(product.price.toString()),
                                trailing: SizedBox(
                                  width: 90,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            final username = widget.user?.id.toString() ??
                                                FirebaseAuth.instance.currentUser?.uid ??
                                                '';
                                            context
                                                .read<CartBloc>()
                                                .add(RemoveProductEvent(product: product, username: username));
                                          },
                                          child: Icon(CupertinoIcons.minus)),
                                      Text(
                                        product.qty!.toString(),
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          final username = widget.user?.id.toString() ??
                                              FirebaseAuth.instance.currentUser?.uid ??
                                              '';
                                          context
                                              .read<CartBloc>()
                                              .add(AddProductEvent(product: product, username: username));
                                        },
                                        child: Icon(CupertinoIcons.add),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'TOTAL: ',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            '\$' + total.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        height: 50,
                        minWidth: double.infinity,
                        color: Theme
                            .of(context)
                            .primaryColor,
                        elevation: 0,
                        onPressed: () {
                          final username =
                              widget.user?.id.toString() ?? FirebaseAuth.instance.currentUser?.uid ?? '';
                          context.read<CartBloc>().add(PayProductEvent(username: username));
                          showSnackBar(context: context, message: 'Payment Success');
                        },
                        child: Text(
                          'PAY NOW!',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      )
                    ],
                  );
                }
                return SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.75,
                  child: Center(
                    child: Lottie.asset('assets/images/empty.json'),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
