import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OrdersController extends GetxController {
  var isLoading = true.obs;
  var orders = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('https://btobapi-production.up.railway.app/api/orders/'),
      );
      if (response.statusCode == 200) {
        orders.value = json.decode(response.body);
      } else {
        Get.snackbar('Error', 'Failed to load orders');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
