import 'package:cached_map/cached_map.dart';
import 'package:flutter_app/cart.dart';
import 'package:flutter_app/product.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  Cart cart = Cart(products: <Product>[].obs);
  RxInt totalItems = 0.obs;
  RxInt cartIndex = 1.obs;
  RxBool progressing = false.obs;

  onInit() {
    loadCart();
    super.onInit();
  }

  Future<Cart> loadCart() async {
    try {
      Map<String, dynamic> cartJson =
      await Mapped.loadFileDirectly(cachedFileName: 'Cart');

      if (cartJson == null) {
        cart.products.value = <Product>[].obs;
      }
      else {
        cart = Cart.fromJson(cartJson);
//        calculateTotalItems();
      }
    }
    catch (e) {
      print(e);
    }
  }


  clearCart(){
    Mapped.deleteFileDirectly(cachedFileName: "Cart");
    cart.products.clear();
  }


  addItem(Product product,int index) {
    if (index != -1) {
      cart.products[index].quantity++;

    }else{
    product.quantity.value = 1;
    cart.products.add(product);
    Mapped.saveFileDirectly(file: cart.toJson(), cachedFileName: 'Cart');
    Fluttertoast.showToast(msg: "Added to cart successfully",);
    }
  }


  removeItem(Product product,int index) {

    if(cart.products[index].quantity>1) {
      cart.products[index].quantity--;
    }else{
      cart.products.removeAt(index);
      Fluttertoast.showToast(msg:"Item removed");
      Mapped.saveFileDirectly(file: cart.toJson(), cachedFileName: 'Cart');
      cartIndex.value = -1.obs;
    }

  }

  removeItemFromCart(Product product,int index) {
    cart.products.removeAt(index);
    Fluttertoast.showToast(msg:"Item removed");
    Mapped.saveFileDirectly(file: cart.toJson(), cachedFileName: 'Cart');
    cartIndex.value = -1.obs;
  }


  removeFullItem(Product product,int index) {
    cart.products.removeAt(index);
    Fluttertoast.showToast(msg:"Item removed");

    Mapped.saveFileDirectly(
        file: cart.toJson(), cachedFileName: 'Cart');
  }


}