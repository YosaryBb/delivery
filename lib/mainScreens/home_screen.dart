import 'package:delivery/mainScreens/new_orders_screen.dart';
import 'package:delivery/mainScreens/parcel_in_progress_screen.dart';
import 'package:flutter/material.dart';

import '../assistanMethods/get_current_location.dart';
import '../authentication/auth_screen.dart';
import '../global/global.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {

  Card makeDashboardItem(String title, IconData iconData,int index ){

    return Card(
      elevation:2,
      margin: const EdgeInsets.all(8),
      child: Container(
          decoration: index ==0 || index == 3  || index == 4
              ? const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.amber,
                  Colors.cyan,
                ],
                begin:  FractionalOffset(0.0, 0.0),
                end:  FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
          )
              :  const BoxDecoration(
      gradient: LinearGradient(
      colors: [
          Colors.redAccent,
          Colors.amber,
          ],
          begin:  FractionalOffset(0.0, 0.0),
      end:  FractionalOffset(1.0, 0.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp,
    )
    ),
        child: InkWell(
          onTap: (){
            if(index == 0){
              //new orden
              Navigator.push(context, MaterialPageRoute(builder:(c)=>  ParcelInProgressScreen()));
            }
            if(index == 1){
              //new orden
            }
            if(index == 2){
              //new orden
            }
            if(index == 3){
              //new orden
            }
            if(index == 4){
              //new orden
            }
            if(index == 5){
              //new orden
              firebaseAuth.signOut().then((value){
                Navigator.push(context, MaterialPageRoute(builder:(c)=> const AuthScreen()));
              });
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children:[
              const SizedBox(height: 50.0),
              Center(
                child: Icon(
                  iconData,
                  size:4,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: Text(title,
                style: const TextStyle(fontSize: 16,
                  color: Colors.black,
                ),)
              ),
            ]
          ),
        ),
        ),
    );
  }

  @override
  void initState() {

    super.initState();
    UserLocation uLocation= UserLocation();
    uLocation.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.cyan,
                  Colors.amber,
                ],
                begin:  FractionalOffset(0.0, 0.0),
                end:  FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        title: Text(
          "welcome"+
          sharedPreferences!.getString("name")!,
    style: const TextStyle(
    fontSize: 25,
    color: Colors.black54,
    fontFamily: "Signatra",
    letterSpacing: 2,
        ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 1),
        child: GridView.count(
               crossAxisCount: 2,
          padding: const EdgeInsets.all(2),
            children: [
              makeDashboardItem("new Avaliable Orders", Icons.assessment, 0),
              makeDashboardItem("Parcel in progress", Icons.airport_shuttle, 1),
              makeDashboardItem("new Avaliable Orders", Icons.location_history, 2),
              makeDashboardItem("history", Icons.done_all, 3),
              makeDashboardItem("total earning", Icons.monetization_on, 4),
              makeDashboardItem("Logout", Icons.logout, 5),

            ],

        ),
      ),
    );
  }
}
