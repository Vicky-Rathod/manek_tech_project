import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manek_tech_project/blocs/prod_state.dart';
import 'package:manek_tech_project/models/product_model.dart';
import 'package:manek_tech_project/blocs/prod_repository.dart';
import 'package:manek_tech_project/utils/const.dart';
import 'package:sqflite/sqlite_api.dart';

import '../services/api_call.dart';

class ProductBloc extends Cubit<ProductState> {
  final productRepository = ProductRepository();
  final Database database;
  ProductBloc({required this.database}) : super(const InitProductState(0));


  List<ProductModel> _cart = [];
  List<ProductModel> get cart => _cart;
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;
  int _count = 1;
  Future<void> getProducts() async {
    try {
      _products = await productRepository.productList(database: database);
      _cart = await productRepository.cartList(database: database);
      if (_products.isEmpty) {
        addProducts();
      }
      emit(InitProductState(_count++));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addProducts() async {
    var apiCall = ApiRequest(
      AppConstant.base_url,
    );
    var dataNew = await apiCall.PostRequest();
    ProductResponseModel productModel = ProductResponseModel.fromJson(dataNew);
    for (var element in productModel.data!) {
      await productRepository.addProducts(
        database: database,
        slug: element.slug,
        createdat: element.createdAt,
        description: element.description,
        featuredimage: element.featuredImage,
        status: element.status,
        price: element.price,
        title: element.title,
      );
    }
    getProducts();
  }
  Future<void> deleteProductFromCart(
      int id,
      ) async {
    try {
      await productRepository.deleteProductToCart(
        database: database,
        id: id,
      );
      getProducts();
      emit(InitProductState(_count++));
    } catch (e) {
      log(e.toString());
    }
  }


  Future<void> addProductToCart(
      int id,
      String slug,
      String createdAt,
      String description,
      String featuredImage,
      int price,
      String status,
      String title) async {
    try {
      await productRepository.addProductToCart(
        database: database,
        slug: slug,
        createdat: createdAt,
        description: description,
        featuredimage: featuredImage,
        status: status,
        price: price,
        title: title,
      );
      getProducts();
      emit(InitProductState(_count++));
    } catch (e) {
      log(e.toString());
    }
  }


}
