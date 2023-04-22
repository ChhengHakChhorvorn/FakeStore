import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../model/user_cart.dart';
import '../../response/product_response.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<GetProductEvent>((event, emit) async {
      final box = await Hive.openBox<UserCart>('cart');
      UserCart userCart = box.get(event.username) ?? UserCart(event.username, []);
      if (userCart.cartProducts.isNotEmpty) {
        emit(CartSuccessState(products: userCart.cartProducts));
      }
    });

    on<PayProductEvent>((event, emit) async {
      final box = await Hive.openBox<UserCart>('cart');
      UserCart userCart = box.get(event.username) ?? UserCart(event.username, []);
      userCart.cartProducts.clear();
      userCart.save();
      emit(CartSuccessState(products: userCart.cartProducts));
    });

    on<AddProductEvent>((event, emit) async {
      final box = await Hive.openBox<UserCart>('cart');
      UserCart userCart = box.get(event.username) ?? UserCart(event.username, []);
      if (userCart.cartProducts.contains(event.product)) {
        int tIndex = userCart.cartProducts.indexWhere((element) => element == event.product);
        userCart.cartProducts[tIndex].qty = userCart.cartProducts[tIndex].qty! + 1;
      } else {
        event.product.qty = 1;
        userCart.cartProducts.add(event.product);
      }
      await box.put(event.username, userCart);
      await userCart.save();
      emit(CartSuccessState(products: userCart.cartProducts));
    });

    on<RemoveProductEvent>((event, emit) async {
      final box = await Hive.openBox<UserCart>('cart');
      UserCart userCart = box.get(event.username) ?? UserCart(event.username, []);

      if (userCart.cartProducts.contains(event.product)) {
        int tIndex = userCart.cartProducts.indexWhere((element) => element == event.product);
        if (userCart.cartProducts[tIndex].qty! > 1) {
          userCart.cartProducts[tIndex].qty = userCart.cartProducts[tIndex].qty! - 1;
          await box.put(event.username, userCart);
          emit(CartSuccessState(products: userCart.cartProducts));
        } else {
          userCart.cartProducts.remove(event.product);
          await box.put(event.username, userCart);
          if (userCart.cartProducts.isEmpty) {
            emit(CartInitial());
          } else {
            emit(CartSuccessState(products: userCart.cartProducts));
          }
        }
      }
    });
  }
}
