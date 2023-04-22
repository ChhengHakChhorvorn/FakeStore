part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartSuccessState extends CartState {
  final List<Product> products;

  CartSuccessState({required this.products});
}

class CartPaySuccessState extends CartState {}
