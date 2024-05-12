import 'package:dzair_data_usage/commune.dart';
import 'package:dzair_data_usage/daira.dart';
import 'package:dzair_data_usage/dzair.dart';
import 'package:dzair_data_usage/langs.dart';
import 'package:dzair_data_usage/wilaya.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/features/cart/controllers/cart_controller.dart';
import 'package:waffir/features/orders/client/controllers/order_controller.dart';
import 'package:waffir/utils/constants/colors.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CartController cartController = Get.find<CartController>();
  ProfileController authController = Get.find<ProfileController>();
  OrderController orderController = Get.find<OrderController>();

  TextEditingController adresseController = TextEditingController();

  late Dzair dzair;
  List<Wilaya?>? wilayas;
  List<Daira?>? dairas;
  List<Commune?>? communes;
  Wilaya? selectedWilaya;
  Daira? selectedDaira;
  Commune? selectedCommune;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dzair = Dzair();
    wilayas = dzair.getWilayat();
    dairas = dzair.getDairat();
    communes = wilayas![0]!.getCommunes();

    selectedWilaya = wilayas![0];
    selectedDaira = dairas![0];
    selectedCommune = communes![0];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Commander', style: TextStyle(color: Colors.grey[900])),
      ),
      body: Obx(() {
        return Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cordonnées de livraison",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700]),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  enabled: orderController.isLoading.value ? false : true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre adresse';
                    }
                    return null;
                  },
                  controller: adresseController,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                      hintText: "Rue N° 12 ...",
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey[600],
                        ),
                      )),
                ),
                const SizedBox(height: 20),
                Text('Wilaya',
                    style: TextStyle(fontSize: 14, color: Colors.grey[900])),
                Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.white,
                  ),
                  child: DropdownButton<Wilaya>(
                    isExpanded: true,
                    value: selectedWilaya,
                    onChanged: (Wilaya? newValue) {
                      setState(() {
                        selectedWilaya = newValue;
                        dairas = selectedWilaya!.getDairas();
                        selectedDaira = dairas![0];
                        communes = selectedDaira!.getCommunes();
                        selectedCommune = communes![0];
                      });
                    },
                    items: wilayas!
                        .map<DropdownMenuItem<Wilaya>>((Wilaya? wilaya) {
                      return DropdownMenuItem<Wilaya>(
                        value: wilaya,
                        child: Text(
                          "${wilaya!.getWilayaCode()!} - ${wilaya.getWilayaName(Language.FR)!}",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 15),
                Text('Daira',
                    style: TextStyle(fontSize: 14, color: Colors.grey[900])),
                Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.white,
                  ),
                  child: DropdownButton<Daira>(
                    isExpanded: true,
                    value: selectedDaira,
                    onChanged: (Daira? newValue) {
                      setState(() {
                        selectedDaira = newValue;
                        communes = selectedDaira!.getCommunes();
                        selectedCommune = communes![0];
                      });
                    },
                    items: dairas!.map<DropdownMenuItem<Daira>>((Daira? daira) {
                      return DropdownMenuItem<Daira>(
                        value: daira,
                        child: Text(
                          daira!.getDairaName(Language.FR)!,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 15),
                Text('Commune',
                    style: TextStyle(fontSize: 14, color: Colors.grey[900])),
                Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.white,
                  ),
                  child: DropdownButton<Commune>(
                    isExpanded: true,
                    value: selectedCommune,
                    onChanged: (Commune? newValue) {
                      setState(() {
                        selectedCommune = newValue;
                      });
                    },
                    items: communes!
                        .map<DropdownMenuItem<Commune>>((Commune? commune) {
                      return DropdownMenuItem<Commune>(
                        value: commune,
                        child: Text(
                          commune!.getCommuneName(Language.FR)!,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Méthode de paiement",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700]),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateProperty.all(TColors.primary),
                        value: 0,
                        groupValue: 0,
                        onChanged: (value) {},
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Paiement à la livraison",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Payer en espèce à la livraison",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Center(
                    child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.orange.withOpacity(0.04);
                              }
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.orange.withOpacity(0.12);
                              }
                              return null;
                            },
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.all(14.0),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            orderController.isLoading.value
                                ? null
                                : orderController.makeOrder(
                                    adresseController.text,
                                    selectedWilaya!.getWilayaName(Language.FR)!,
                                    selectedDaira!.getDairaName(Language.FR)!,
                                    selectedCommune!
                                        .getCommuneName(Language.FR)!,
                                  );
                          }
                        },
                        child: Obx(() {
                          return orderController.isLoading.value
                              ? const SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Placer la commande',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.arrow_forward_ios, size: 16),
                                  ],
                                );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
