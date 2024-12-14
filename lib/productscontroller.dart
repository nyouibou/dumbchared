import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductsController extends GetxController {
  var isLoading = true.obs;
  var products = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('https://btobapi-production.up.railway.app/api/products/'),
      );
      if (response.statusCode == 200) {
        products.value = json.decode(response.body);
      } else {
        Get.snackbar('Error', 'Failed to load products');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
