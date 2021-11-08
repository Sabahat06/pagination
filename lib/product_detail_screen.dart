import 'package:flutter/material.dart';
import 'package:flutter_app/cart_controller.dart';
import 'package:flutter_app/cart_screen.dart';
import 'package:flutter_app/color_palates.dart';
import 'package:flutter_app/my_filled_button.dart';
import 'package:flutter_app/product.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatelessWidget {
  CartController cartController = Get.find();
  RxInt cartIndex = 1.obs;

  Product product;
  ProductDetailScreen(this.product){
    cartIndex.value =  cartController.cart.products.indexWhere((element) => element.id==product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Detail"), actions: [IconButton(onPressed: (){Get.to(() => CartScreen());}, icon: Icon(Icons.shopping_cart),)],),
      body: Column(
        children: [
          Text(product.title),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),
            width: double.infinity,
            height: 200,
            child: Text(product.photo),
          ),
          const SizedBox(height: 10),
          Obx(
            () => cartIndex.value == -1
                ? GestureDetector(
              onTap: (){
                cartController.addItem(product, cartIndex.value);
                cartIndex.value=0;
              },
              child: Container(
                width: double.infinity,
                height: 50,
                color: Colors.green,
                child: const Center(child: Text('Add to cart')),
              ),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyFilledButton(
                  width: Get.width*0.27,
                  ontap: () {
                    if(cartController.cart.products[cartIndex.value].quantity.value == 1){
                      cartController.removeItem(product,cartIndex.value);
                      cartIndex.value=-1;
                    }else{
                      cartController.removeItem(product,cartIndex.value);
                    }
                  },
                  height: 45,
                  txt: '–',
                  borderRadius: 10,
                  color: ColorPalette.orange,
                ),
                Text(cartController.cart.products[cartIndex.value].quantity.value.toString(), style: const TextStyle(fontSize: 18),),
                MyFilledButton(
                  width: Get.width*0.27,
                  ontap: () {
                    cartController.addItem(product,cartIndex.value);
                  },
                  height: 45,
                  txt: '+',
                  borderRadius: 10,
                  color: ColorPalette.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
