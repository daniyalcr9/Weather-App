import 'dart:convert';
import 'dart:math';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchEditingcontroller = new TextEditingController();
  String username = "";

  void showData() {
    print("$username");
  }

  void timer() {
    Future.delayed(Duration(seconds: 9), () {
      print("Alarm is ringing");
    });
    print("hey");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //showData();
    print("This is a init state");
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var city_name = [
      "Karachi",
      "Lahore",
      "Islamabad",
      "Delhi",
      "Mumbai",
      "Hyderabad",
      "London"
    ];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    Map info = {};
    info = ModalRoute.of(context)!.settings.arguments as Map;

    String temp = (info["temp_value"]);
    String air = (info["air_speed_value"]);
    if (temp == "NA") {
      print("NA");
    } else {
      temp = ((info["temp_value"]).toString()).substring(0, 4);
      air = ((info["air_speed_value"]).toString()).substring(0, 4);
    }

    String icon = info["icon_value"];
    String getcity = info["city_value"];
    String hum = info["hum_value"];

    String des = info["des_value"];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: NewGradientAppBar(
            gradient: LinearGradient(colors: [
              Colors.blue,
              Colors.blueAccent,
            ]),
          )),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.lightBlueAccent],
              ),
            ),
            child: Column(
              children: [
                Container(
                  //search container

                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if ((searchEditingcontroller.text)
                                  .replaceAll(" ", "") ==
                              "") {
                            print("Blank search");
                          } else {
                            Navigator.pushReplacementNamed(context, "/loading",
                                arguments: {
                                  "searchText": searchEditingcontroller.text,
                                });
                          }
                        },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            color: Colors.blue,
                          ),
                          margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchEditingcontroller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search $city"),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        padding: EdgeInsets.all(26),
                        child: Row(
                          children: [
                            Image.network(
                                "http://openweathermap.org/img/wn/$icon@2x.png"),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                Text(
                                  "$des",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "In $getcity",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 10,
                        ),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(WeatherIcons.thermometer),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$temp",
                                  style: TextStyle(fontSize: 90),
                                ),
                                Text(
                                  "C",
                                  style: TextStyle(fontSize: 30),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.day_windy),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "$air",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Km/hr"),
                          ],
                        ),
                        height: 200,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.humidity),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "$hum",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Percent")
                          ],
                        ),
                        height: 200,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Made by: Daniyal Awan"),
                      Text("Data provided by Openweathermap.org"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
