import 'package:http/http.dart' as http;

import '../model/Product model.dart';

Future<List<ProductModel>> getProducts() async {
  http.Response response =
      await http.get(Uri.parse('https://fakestoreapi.com/products'));
  return productModelFromJson(response.body);
}
