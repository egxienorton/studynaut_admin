import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsInDetail extends StatelessWidget {
  dynamic argument = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.pinkAccent,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                image: DecorationImage(
                  image: NetworkImage(argument[0]['postUrl']),
                  fit: BoxFit.cover
                ),

              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(16),
              child: ListView(
                children: [
                  Text(
                    argument[0]['content'],
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
