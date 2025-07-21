import 'package:flutter/material.dart';

class DeliveryPartner extends StatefulWidget {
  const DeliveryPartner({super.key});

  @override
  State<DeliveryPartner> createState() => _DeliveryPartnerState();
}

class _DeliveryPartnerState extends State<DeliveryPartner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Delivery Partner")));
  }
}
