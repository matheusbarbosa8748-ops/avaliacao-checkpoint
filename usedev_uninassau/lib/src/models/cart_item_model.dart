import 'product_model.dart';

class CartItemModel {
  final ProductModel product;
  final int quantity;
  final String? size;

  CartItemModel({
    required this.product,
    this.quantity = 1,
    this.size,
  });

  String get key => size != null ? '${product.id}_$size' : '${product.id}';

  CartItemModel copyWith({
    ProductModel? product,
    int? quantity,
    String? size,
  }) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
    );
  }
}
