import 'package:flutter_app/product.dart';
import 'package:get/get.dart';




class Cart {
  RxList<Product> products = <Product>[].obs;
  Cart({this.products});

  Cart.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products= <Product>[].obs;
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
