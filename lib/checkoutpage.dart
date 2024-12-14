import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cartcontroller.dart';

class CheckoutPage extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total: \$${cartController.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cartController.placeOrder(); // Place the order via API
              },
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
