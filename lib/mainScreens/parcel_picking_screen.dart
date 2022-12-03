import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/assistanMethods/get_current_location.dart';
import 'package:delivery/global/global.dart';
import 'package:delivery/mainScreens/parcel_delivery_screen.dart';
import 'package:delivery/masps/map_utils.dart';
import 'package:flutter/material.dart';

class ParcelPickingScreen extends StatefulWidget {
  String? purchaserId;
  String? sellerId;
  String? getOrderID;
  String? purchaserAddress;
  double? purchaserLat;
  double? purchaserLng;

  ParcelPickingScreen({
    this.purchaserId,
    this.sellerId,
    this.getOrderID,
    this.purchaserLat,
    this.purchaserAddress,
    this.purchaserLng,
  });

  @override
  State<ParcelPickingScreen> createState() => _ParcelPickingScreenState();
}

class _ParcelPickingScreenState extends State<ParcelPickingScreen> {
  double? sellerLat, sellerLng;


  getSellerData() async {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(widget.sellerId)
        .get()
        .then((documentSnapshot)
    {
     // sellerLat =DocumentSnapshot.data()!["lat"];
     // sellerLng = DocumentSnapshot.data()!["lng"];
    });


  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSellerData();
  }

  confirmParcelHasBeenPicked(getOrderId, sellerId, purchaserId, purchaserAddress, purchaserLat, purchaserLng)
  {

    FirebaseFirestore.instance.collection("orders").doc(getOrderId).update({
      "status": "delivering",
      "address": completeAddress,
      "lat": position!.latitude,
      "lng": position!.longitude,
    });
    Navigator.push(context, MaterialPageRoute(builder: (c)=> ParcelDeliveringScreen(
      purchaserId: purchaserId,
      purchaserAddress: purchaserAddress,
      puchaserLat: purchaserLat,
      sellerId:  sellerId,
      getOrderId: getOrderId,

    )));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "Images/confirm1.png",
            width: 350,
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              MapUtils.lauchMapFromSourceToDestination(position?.latitude,
                  position!.longitude, sellerLat, sellerLng);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/restaurant.png",
                  width: 50,
                ),
                const SizedBox(
                  height: 7,
                ),
                Column(
                  children: const [
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      "show cafe/Restaurant Location",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Signatra",
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //    context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const MySplashScreen()));
                  UserLocation uLocation = UserLocation();
                  uLocation.getCurrentLocation();
                  confirmParcelHasBeenPicked(
                      widget.getOrderID,
                      widget.sellerId,
                      widget.purchaserId,
                      widget.purchaserAddress,
                      widget.purchaserLat,
                      widget.purchaserLng);


                },
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Colors.cyan,
                      Colors.amber,
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  )),
                  width: MediaQuery.of(context).size.width - 90,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Order has been Piked-confirmed",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
