import 'package:flutter/material.dart';

import '../controllers/MyCart controller.dart';

class Demo extends StatelessWidget {
  final MyCartController myCartController = MyCartController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(myCartController.data.read('Data')[index].title),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('_______${myCartController.data.read('Data')[1].title}');
        },
      ),
    );
  }
}
