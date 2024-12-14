import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'products_page.dart';
import 'orders_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'API Integration Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => ProductsPage());
              },
              child: Text('View Products'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => OrdersPage());
              },
              child: Text('View Orders'),
            ),
          ],
        ),
      ),
    );
  }
}
