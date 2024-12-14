import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ordercontroller.dart';

class OrdersPage extends StatelessWidget {
  final OrdersController ordersController = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: Obx(() {
        if (ordersController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (ordersController.orders.isEmpty) {
          return Center(child: Text('No orders found.'));
        } else {
          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: ordersController.orders.length,
            itemBuilder: (context, index) {
              final order = ordersController.orders[index];
              return OrderCard(order: order);
            },
          );
        }
      }),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text('Order ID: ${order['id']}'),
        subtitle: Text('Status: ${order['status']}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Business User: ${order['business_user_name']}'),
                Text('Order Date: ${order['order_date']}'),
                Text('Billing Address: ${order['billing_address']}'),
                Text('Total Price: \$${order['total_price']}'),
                Divider(),
                Text(
                  'Products:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: order['order_products'].length,
                  itemBuilder: (context, index) {
                    final product = order['order_products'][index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${product['quantity']}'),
                      ),
                      title: Text(product['product_name']),
                      subtitle: Text('Price: \$${product['price']}'),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
