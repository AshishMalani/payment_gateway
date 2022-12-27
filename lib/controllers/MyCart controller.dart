import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../model/Product model.dart';

class MyCartController extends GetxController {
  List<ProductModel> myCartList = [];
  List<ProductModel> set = [];
  final data = GetStorage();
  Razorpay _razorpay = Razorpay();

  bool paymentDone = false;

  @override
  void onInit() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.onInit();
  }

  bool isProductsExits(int productId) {
    bool result = false;

    for (var product in myCartList) {
      if (product.id == productId) {
        result = true;
        break;
      } else {
        result = false;
      }
    }

    print(result);
    return result;
  }

  void addProduct(ProductModel product) {
    myCartList.add(product);
    set = myCartList;
    data.write('Data', set);
    update();
  }

  void removeProduct(int productId) {
    for (var product in myCartList) {
      if (product.id == productId) {
        myCartList.remove(product);
        update();
        break;
      }
    }
  }

  double getTotalPrice() {
    double total = 0;
    myCartList.forEach((element) {
      total = total + element.price;
    });
    return total.floorToDouble();
  }

  void buyNowOnPressed({required double price}) {
    _razorpay.open({
      'key': 'rzp_test_c4eNzNCmn36EQu',
      'amount': price * 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'mailto:test@razorpay.com'}
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    myCartList.clear();
    paymentDone = true;
    update();
    // Do something when payment succeeds
    print("paymentId: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("payment fails: ${response.error}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("walletName: ${response.walletName}");
  }
}
