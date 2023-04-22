import 'package:hive/hive.dart';

import '../response/product_response.dart';

part 'user_cart.g.dart';

@HiveType(typeId: 8)
class UserCart extends HiveObject {
  @HiveField(0)
  late String userId;

  @HiveField(1)
  late List<Product> cartProducts;

  UserCart(this.userId, this.cartProducts);
}
