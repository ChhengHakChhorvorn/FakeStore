part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class GetProductEvent extends CartEvent {
  final String username;

  GetProductEvent({required this.username});
}

class AddProductEvent extends CartEvent {
  final Product product;
  final String username;

  AddProductEvent({required this.product, required this.username});
}

class RemoveProductEvent extends CartEvent {
  final Product product;
  final String username;

  RemoveProductEvent({required this.product, required this.username});
}

class PayProductEvent extends CartEvent {
  final String username;

  PayProductEvent({required this.username});
}
