import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/working/working.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String city = "London";
  String temp = "";
  String hum = "";
  String air_speed = "";
  String des = "";
  String main = "";
  String loc = "";
  String icon = "";
  void startApp(String city) async {
    working instance = working(location: city);
    await instance.getData();

    temp = instance.temp;
    hum = instance.humidity;
    air_speed = instance.air_speed;
    des = instance.description;
    main = instance.main;
    icon = instance.icon;
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value": temp,
        "hum_value": hum,
        "air_speed_value": air_speed,
        "des_value": des,
        "main_value": main,
        "loc_value": loc,
        "icon_value": icon,
        "city_value": city,
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map search = {};
    search = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;

    if (search?.isNotEmpty ?? false) {
      city = search["searchText"];
    }
    startApp(city);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 230,
              ),
              Image.asset(
                "images/logo.png",
                height: 160,
                width: 160,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Weather App",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Made by Daniyal",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              SizedBox(
                height: 30,
              ),
              SpinKitWave(
                color: Colors.white,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue[500],
    );
  }
}
