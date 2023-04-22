// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_cart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserCartAdapter extends TypeAdapter<UserCart> {
  @override
  final int typeId = 8;

  @override
  UserCart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserCart(
      fields[0] as String,
      (fields[1] as List).cast<Product>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserCart obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.cartProducts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
