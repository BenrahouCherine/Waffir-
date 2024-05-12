import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderErrorScreen extends StatefulWidget {
  const OrderErrorScreen({super.key});

  @override
  State<OrderErrorScreen> createState() => _OrderErrorScreenState();
}

class _OrderErrorScreenState extends State<OrderErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.error_outline_outlined,
              color: Colors.red,
              size: 150,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Une erreur s\'est produite!',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Veuillez réessayer plus tard',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: Get.width * 0.8,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(249, 115, 22, 0.93))),
                onPressed: () {
                  Get.back();
                  Get.back();
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text("Retour à l'acceuil"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
