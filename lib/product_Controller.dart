
import 'package:flutter/material.dart';
import 'package:flutter_app/http_service.dart';
import 'package:flutter_app/product.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{

  RxInt currentPage = 1.obs;
  RxInt currentSearchPage = 1.obs;
  Rx<ProductsModal> productsModal = ProductsModal(products: <Product>[].obs,totalPages: 0).obs;
  RxBool search = false.obs;
  RxBool progressing = false.obs;

  ProductController(){
    loadProducts(loadMore: false);
  }

  Future<void> loadProducts({@required bool loadMore}) async {

    if(!loadMore)
    {
      progressing.value = true;
      ProductsModal productResult = await HttpService.getProducts(currentPage.value)??ProductsModal(products: <Product>[].obs,totalPages: 0).obs;
      progressing.value = false;
      productsModal.value = productResult;
    }
    else
    {
      currentPage.value++;
      ProductsModal productResult =await HttpService.getProducts(currentPage.value);
      productsModal.value.products.addAll(productResult.products);
      update();
      print("added");
    }
  }


}