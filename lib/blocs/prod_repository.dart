import 'package:manek_tech_project/models/product_model.dart';
import 'package:sqflite/sqlite_api.dart';

class ProductRepository {
  Future<List<ProductModel>> productList({
    required Database database,
  }) async {
    final datas = await database.rawQuery('SELECT * FROM products');
    List<ProductModel> products = [];
    for (var item in datas) {
      products.add(ProductModel(
        slug: item['slug'] as String,
        description: item['description'] as String,
        title: item['title'] as String,
        createdAt: item['created_at'] as String,
        featuredImage: item['featured_image'] as String,
        id: item['id'] as int,
        price: item['price'] as int,
        status: item['status'] as String,
      ));
    }
    return products;
  }

  Future<List<ProductModel>> cartList({
    required Database database,
  }) async {
    final datas = await database.rawQuery('SELECT * FROM cart GROUP BY slug');
    List<ProductModel> products = [];
    for (var item in datas) {
      final new_data = await database.rawQuery(
          'SELECT COUNT(slug) as unit, SUM(price) as price FROM cart WHERE slug = "${item['slug']}"');
      print(new_data);
      products.add(ProductModel(
        slug: item['slug'] as String,
        description: item['description'] as String,
        title: item['title'] as String,
        createdAt: item['created_at'] as String,
        featuredImage: item['featured_image'] as String,
        id: item['id'] as int,
        price: new_data[0]['price'] as int,
        unit: new_data[0]['unit'] as int,
        status: item['status'] as String,
      ));
    }
    return products.toSet().toList();
  }

  Future<dynamic> addProducts({
    required Database database,
    required String? slug,
    required String? title,
    required String? description,
    required int? price,
    required String? featuredimage,
    required String? status,
    required String? createdat,
  }) async {
    return await database.transaction((txn) async {
      await txn.rawInsert(
          "INSERT INTO products (slug ,title, description,price,featured_image, status, created_at) VALUES ('$slug','$title', '$description', '$price','$featuredimage', '$status', '$createdat')");
    });
  }

  Future<dynamic> addProductToCart({
    required Database database,
    required String? slug,
    required String? title,
    required String? description,
    required int? price,
    required String? featuredimage,
    required String? status,
    required String? createdat,
  }) async {
    return await database.transaction((txn) async {
      await txn.rawInsert(
          "INSERT INTO cart (slug ,title, description,price,featured_image, status, created_at) VALUES ('$slug','$title', '$description', '$price','$featuredimage', '$status', '$createdat')");
    });
  }

  Future<dynamic> deleteProductToCart({
    required Database database,
    required int? id,
  }) async {
    return await database.transaction((txn) async {
      await txn.rawDelete('DELETE FROM cart where id = $id');
    });
  }
}
