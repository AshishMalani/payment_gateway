import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/Homepage controller.dart';
import '../controllers/Internet controller.dart';
import '../controllers/MyCart controller.dart';
import 'MyCart screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.to(Demo());
      //   },
      // ),
      appBar: AppBar(title: const Text("Home"), actions: [
        IconButton(
            onPressed: () {
              Get.to(MyCart());
            },
            icon: Icon(Icons.add_shopping_cart_rounded))
      ]),
      body: GetBuilder<InternetCheckController>(
        builder: (InternetCheckController internetCheckController) {
          if (internetCheckController.internetCheckLoader) {
            return Material();
          } else {
            if (internetCheckController.internet) {
              var homeController = Get.put(HomeController());
              var myCartController = Get.put(MyCartController());

              return Obx(() {
                if (!homeController.isLoading.value) {
                  return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "${homeController.products[index].image}")),
                          title: Text(
                            '${homeController.products[index].title}',
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            'Price RS. ${homeController.products[index].price}',
                            maxLines: 1,
                          ),
                          trailing: GetBuilder<MyCartController>(
                              builder: (MyCartController controller) {
                            return IconButton(
                                onPressed: () {
                                  if (!controller.isProductsExits(
                                      homeController.products[index].id)) {
                                    myCartController.addProduct(
                                        homeController.products[index]);
                                  } else {
                                    myCartController.removeProduct(
                                        homeController.products[index].id);
                                  }
                                },
                                icon: controller.isProductsExits(
                                        homeController.products[index].id)
                                    ? Icon(Icons.shopping_cart_rounded)
                                    : Icon(Icons.shopping_cart_outlined));
                          }),
                        );
                      },
                      itemCount: homeController.products.length);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              });
            } else {
              return Material(
                child: Center(
                  child: Text("No Internet Connection Available"),
                ),
              );
            }
          }
        },
        init: InternetCheckController(),
      ),
    );
  }
}
