import 'dart:convert';

ProductResponseModel productModelFromJson(String str) =>
    ProductResponseModel.fromJson(json.decode(str));

String productModelToJson(ProductResponseModel data) =>
    json.encode(data.toJson());

class ProductResponseModel {
  ProductResponseModel({
    this.status,
    this.message,
    this.totalRecord,
    this.totalPage,
    this.data,
  });

  int? status;
  String? message;
  int? totalRecord;
  int? totalPage;
  List<ProductModel>? data;

  ProductResponseModel copyWith({
    int? status,
    String? message,
    int? totalRecord,
    int? totalPage,
    List<ProductModel>? data,
  }) =>
      ProductResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        totalRecord: totalRecord ?? this.totalRecord,
        totalPage: totalPage ?? this.totalPage,
        data: data ?? this.data,
      );

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductResponseModel(
        status: json["status"],
        message: json["message"],
        totalRecord: json["totalRecord"],
        totalPage: json["totalPage"],
        data: List<ProductModel>.from(
            json["data"].map((x) => ProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "totalRecord": totalRecord,
        "totalPage": totalPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProductModel {
  ProductModel({
    this.id,
    this.slug,
    this.title,
    this.description,
    this.price,
    this.featuredImage,
    this.status,
    this.createdAt,
    this.unit,
  });

  int? id;
  String? slug;
  String? title;
  String? description;
  int? price;
  String? featuredImage;
  String? status;
  String? createdAt;
  int? unit = 0;

  ProductModel copyWith({
    int? id,
    String? slug,
    String? title,
    String? description,
    int? price,
    int? unit,
    String? featuredImage,
    String? status,
    String? createdAt,
  }) =>
      ProductModel(
        id: id ?? this.id,
        slug: slug ?? this.slug,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        unit: unit ?? this.unit,
        featuredImage: featuredImage ?? this.featuredImage,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        slug: json["slug"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        unit: json["unit"] ?? 0,
        featuredImage: json["featured_image"],
        status: json["status"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title,
        "description": description,
        "price": price,
        "featured_image": featuredImage,
        "status": status,
        "created_at": createdAt!,
      };
}
