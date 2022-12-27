import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/Internet controller.dart';
import '../controllers/MyCart controller.dart';

class MyCart extends StatelessWidget {
  MyCart({Key? key}) : super(key: key);

  final myCartController = Get.find<MyCartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MyCart")),
      body: GetBuilder<InternetCheckController>(
        builder: (InternetCheckController internetCheckController) {
          if (internetCheckController.internetCheckLoader) {
            return Material();
          } else {
            if (internetCheckController.internet) {
              if (myCartController.myCartList.isEmpty) {
                return Center(
                  child: Text('No items available'),
                );
              } else {
                return GetBuilder<MyCartController>(
                    builder: (MyCartController myCartController) {
                  if (myCartController.paymentDone) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Payment done"),
                          TextButton(
                              onPressed: () {
                                Get.back();
                                myCartController.paymentDone = false;
                              },
                              child: Text("Ok")),
                        ],
                      ),
                    );
                  } else {
                    return Stack(
                      children: [
                        Positioned(
                          bottom: 115,
                          left: 0,
                          right: 0,
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                      colors: [
                                    Colors.cyan,
                                    Colors.indigo,
                                  ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.topRight)
                                  .createShader(bounds);
                            },
                            child: Center(
                              child: Text(
                                "Payment",
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 3,
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(0, 2),
                                        blurRadius: 10,
                                      )
                                    ],
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                  "${myCartController.myCartList[index].image}",
                                )),
                                title: Text(
                                  '${myCartController.myCartList[index].title}',
                                  maxLines: 1,
                                ),
                                subtitle: Text(
                                  'Price RS. ${myCartController.myCartList[index].price}',
                                  maxLines: 1,
                                ),
                              );
                            },
                            itemCount: myCartController.myCartList.length),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Material(
                            elevation: 20,
                            child: SizedBox(
                              height: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Total: RS. ${myCartController.getTotalPrice()}",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      myCartController.buyNowOnPressed(
                                          price:
                                              myCartController.getTotalPrice());
                                    },
                                    child: Text("Buy Now"),
                                  ),
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                          ),
                        )
                      ],
                    );
                  }
                });
              }
            } else {
              return Material(
                child: Center(
                  child: Text("No Internet connection available"),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
