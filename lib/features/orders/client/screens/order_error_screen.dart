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
            const Text(
              'Une erreur s\'est produite lors de la passation de la commande!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            const Text(
              'Veuillez réessayer plus tard',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
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
