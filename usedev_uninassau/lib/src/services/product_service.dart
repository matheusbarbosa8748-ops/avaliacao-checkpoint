import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

class ProductService {
  static const String baseUrl = 'https://fakestoreapi.com';

  /// Obtém todos os produtos da API
  static Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final products = jsonData
            .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        throw Exception(
          'Falha ao carregar produtos. Código: ${response.statusCode}',
        );
      }
    } on http.ClientException catch (e) {
      throw Exception('Erro de conexão: ${e.message}');
    } catch (e) {
      throw Exception('Erro ao processar dados: $e');
    }
  }

  /// Obtém um produto específico pelo ID
  static Future<ProductModel> getProductById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/$id'),
      );

      if (response.statusCode == 200) {
        final ProductModel product =
            ProductModel.fromJson(jsonDecode(response.body));
        return product;
      } else {
        throw Exception(
          'Produto não encontrado. Código: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erro ao carregar produto: $e');
    }
  }

  /// Obtém produtos de uma categoria específica
  static Future<List<ProductModel>> getProductsByCategory(
    String category,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/category/$category'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final products = jsonData
            .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        throw Exception(
          'Falha ao carregar produtos. Código: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erro ao carregar produtos da categoria: $e');
    }
  }
}
