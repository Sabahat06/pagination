
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/cart_controller.dart';
import 'package:flutter_app/product.dart';
import 'package:flutter_app/product_Controller.dart';
import 'package:flutter_app/product_detail_screen.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryScreen extends StatelessWidget {
  CartController cartController = Get.put(CartController());
  ProductController controller = ProductController();
  RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text('Personal Details', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
        () => controller.search.value ? Center(child: CircularProgressIndicator(),) : Padding(
          padding: const EdgeInsets.all(15.0),
          child: Obx(
            () => SmartRefresher(
              enablePullUp: controller.search.value
                  ? !(controller.productsModal.value.totalPages==controller.currentSearchPage.value)
                  : !(controller.productsModal.value.totalPages==controller.currentPage.value),
              controller: _refreshController,
              onRefresh: (){
                if(controller.search.value)
                {
                    _refreshController.refreshCompleted();
                }
                else
                {
                  controller.loadProducts(loadMore: false).then((value)  {
                    _refreshController.refreshCompleted();
                  });
                }
              },
              onLoading: (){
                controller.loadProducts(loadMore: true).then((value) {_refreshController.loadComplete();});
              },
              child: ListView.builder(
                // shrinkWrap: true,
                itemCount: controller.productsModal.value.products.length,
                itemBuilder:(context, index) => renderListItem(controller.productsModal.value.products[index])
              ),
            ),
          ),
        ),
      ),
    );
  }

  renderListItem(Product product){
    return GestureDetector(
      onTap: (){Get.to(() => ProductDetailScreen(product));},
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
            ),
            width: double.infinity,
            height: 200,
            child: Text(product.photo),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
