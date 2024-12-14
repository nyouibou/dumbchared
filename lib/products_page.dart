import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cartpage.dart';
import 'productscontroller.dart';
import 'cartcontroller.dart';

class ProductsPage extends StatelessWidget {
  final ProductsController productsController = Get.put(ProductsController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(() => CartPage());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (productsController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (productsController.products.isEmpty) {
          return Center(child: Text('No products found.'));
        } else {
          return GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.7,
            ),
            itemCount: productsController.products.length,
            itemBuilder: (context, index) {
              final product = productsController.products[index];
              return ProductCard(
                product: product,
                onAddToCart: () => cartController.addToCart(product),
              );
            },
          );
        }
      }),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onAddToCart;

  ProductCard({required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              product['image'],
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 120,
                  color: Colors.grey[300],
                  child: Center(child: Icon(Icons.broken_image, size: 50)),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product['product_name'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Price: \$${product['price']}',
              style: TextStyle(color: Colors.green),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: onAddToCart,
              child: Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
