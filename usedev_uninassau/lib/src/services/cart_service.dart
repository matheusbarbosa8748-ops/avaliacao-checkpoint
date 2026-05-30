import 'package:flutter/foundation.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartService extends ChangeNotifier {
  CartService._privateConstructor();

  static final CartService instance = CartService._privateConstructor();

  final Map<String, CartItemModel> _items = {};

  List<CartItemModel> get items => _items.values.toList();

  void addProduct(ProductModel product, {int quantity = 1, String? size}) {
    final newItem = CartItemModel(
      product: product,
      quantity: quantity,
      size: size,
    );
    final key = newItem.key;
    
    if (_items.containsKey(key)) {
      final existingItem = _items[key]!;
      _items[key] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
    } else {
      _items[key] = newItem;
    }
    notifyListeners();
  }

  void removeProduct(String key) {
    _items.remove(key);
    notifyListeners();
  }

  void updateQuantity(String key, int quantity) {
    if (!_items.containsKey(key)) return;
    
    if (quantity <= 0) {
      _items.remove(key);
    } else {
      _items[key] = _items[key]!.copyWith(quantity: quantity);
    }
    notifyListeners();
  }

  void updateSize(String key, String newSize) {
    if (!_items.containsKey(key)) return;

    final oldItem = _items.remove(key);
    if (oldItem != null) {
      final itemWithNewSize = oldItem.copyWith(size: newSize);
      final newKey = itemWithNewSize.key;
      
      if (_items.containsKey(newKey)) {
        final existingItem = _items[newKey]!;
        _items[newKey] = existingItem.copyWith(
          quantity: existingItem.quantity + oldItem.quantity,
        );
      } else {
        _items[newKey] = itemWithNewSize;
      }
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  int get totalItems => _items.values.fold(0, (s, i) => s + i.quantity);

  double get totalPrice =>
      _items.values.fold(0.0, (s, i) => s + i.quantity * i.product.price);
}
