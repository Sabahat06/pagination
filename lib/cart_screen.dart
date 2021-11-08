import 'package:flutter/material.dart';
import 'package:flutter_app/cart_controller.dart';
import 'package:flutter_app/product.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  CartController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart'),),
      body: Obx(
        () => controller.cart.products.length == 0 ? Center(child: Text('No Item in Cart'),) :
          controller.progressing.value
              ? Center(child: CircularProgressIndicator(),)
              : ListView.builder(
            // shrinkWrap: true,
              itemCount: controller.cart.products.length,
              itemBuilder:(context, index) => renderListItem(controller.cart.products.value[index], index)
             ),
      ),


    );
  }
  renderListItem(Product product, int index){
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
          ),
          width: double.infinity,
          height: 200,
          child: Column(
            children: [
              Text(product.photo),
              const Spacer(),
              GestureDetector(
                onTap: (){controller.removeItem(product, index);},
                child: const Text('Remove Item'),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
