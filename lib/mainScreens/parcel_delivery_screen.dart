import 'package:flutter/material.dart';

class ParcelDeliveringScreen extends StatefulWidget
{
String? purchaserId;
String? purchaserAddress;
double? puchaserLat;
double? puchaserLng;
String? sellerId;
String? getOrderId;


ParcelDeliveringScreen({
  this.purchaserId,
  this.purchaserAddress,
  this.puchaserLat,
  this.puchaserLng,
  this.sellerId,
  this.getOrderId,

});

  @override
  State<ParcelDeliveringScreen> createState() => _ParcelDeliveringScreenState();
}

class _ParcelDeliveringScreenState extends State<ParcelDeliveringScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
