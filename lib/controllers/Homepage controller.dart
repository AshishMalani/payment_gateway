import 'package:get/get.dart';

import '../apis/Get product.dart';
import '../model/Product model.dart';

class HomeController extends GetxController {
  late List<ProductModel> products;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    setProductFromApi();
    super.onInit();
  }

  Future<void> setProductFromApi() async {
    products = await getProducts();
    isLoading.value = false;
  }
}
