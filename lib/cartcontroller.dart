import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'products_page.dart';

class CartController extends GetxController {
  var cartItems = [].obs;

  void addToCart(Map<String, dynamic> product) {
    final index = cartItems.indexWhere((item) => item['id'] == product['id']);
    if (index != -1) {
      cartItems[index]['quantity']++;
    } else {
      final cartItem = {
        ...product,
        'quantity': 1,
      };
      cartItems.add(cartItem);
    }
  }

  void removeFromCart(int productId) {
    cartItems.removeWhere((item) => item['id'] == productId);
  }

  double get totalPrice => cartItems.fold(
        0.0,
        (sum, item) =>
            sum + (double.parse(item['price'].toString()) * item['quantity']),
      );

  Future<void> placeOrder() async {
    if (cartItems.isEmpty) {
      Get.snackbar('Error', 'Cart is empty');
      return;
    }

    final orderData = {
      "business_user": 1,
      "order_date": DateTime.now().toIso8601String(),
      "total_price": totalPrice.toStringAsFixed(2),
      "billing_address": "Default Address",
      "status": "Processing",
      "order_type": "Online",
      "order_products": cartItems.map((item) {
        return {
          "product": item['id'],
          "quantity": item['quantity'],
          "price": item['price'],
        };
      }).toList(),
    };

    print('Order Data: ${json.encode(orderData)}');

    try {
      final response = await http.post(
        Uri.parse('https://btobapi-production.up.railway.app/api/orders/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(orderData),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        cartItems.clear();
        Get.snackbar('Success', 'Order placed successfully');
        Get.offAll(() => ProductsPage());
      } else {
        Get.snackbar('Error', 'Failed to place order: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
      Get.snackbar('Error', 'Failed to place order: $e');
    }
  }
}
