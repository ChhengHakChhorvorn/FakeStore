import 'package:fake_store/data/bloc/cart_bloc/cart_bloc.dart';
import 'package:fake_store/data/response/user_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/response/product_response.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    Key? key,
    required this.product,
    this.user,
  }) : super(key: key);
  final Product product;
  final UserResponse? user;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                BackButton(),
              ],
            ),
            Text(
              widget.product.title!,
              maxLines: 3,
              style: TextStyle(
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 300,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                widget.product.imageUrl!,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$' + widget.product.price!.toString(),
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.star_fill,
                      color: Colors.yellow.shade700,
                      size: 35,
                    ),
                    Text(
                      '  ${widget.product.rating!.rate} (${widget.product.rating!.count})',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Description:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.product.description!,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: MaterialButton(
                elevation: 0,
                onPressed: () {
                  final username = widget.user?.id.toString() ?? FirebaseAuth.instance.currentUser?.uid ?? '';
                  context.read<CartBloc>().add(AddProductEvent(product: widget.product, username: username));
                },
                child: Text('Add to cart', style: TextStyle(fontSize: 15, color: Colors.white)),
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
