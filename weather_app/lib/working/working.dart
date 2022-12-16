import 'dart:convert';
import 'package:http/http.dart';

class working {
  String? location;
  //constructor
  working({this.location}) {
    location = this.location;
  }

  String humidity = "";
  String temp = "";
  String air_speed = "";
  String description = "";
  String main = "";
  String icon = "";

  Future<void> getData() async {
    try {
      Response response = await get(
        (Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=89a368bf56260b05894378c11e45db05')),
      );
      Map data = jsonDecode(response.body);
      print(data);
      //getting description
      List weather_data = data["weather"];
      Map weather_main_data = weather_data[0] as Map;
      String get_main_des = weather_main_data["main"];
      String get_desc = weather_main_data["description"];

      //getting temp/humidity
      Map temp_data = data['main'];
      String get_humidity = temp_data['humidity'].toString();
      double get_temp = temp_data['temp'] - 273.15;

      //getting air_speed
      Map wind = data["wind"];
      double get_air_speed = wind["speed"] / 0.27777777777778;

      //assigning values
      temp = get_temp.toString();
      humidity = get_humidity;
      air_speed = get_air_speed.toString();
      description = get_desc;
      main = get_main_des;
      icon = weather_main_data["icon"].toString();
    } catch (e) {
      temp = "NA";
      humidity = "NA";
      air_speed = "NA";
      description = "NA";
      main = "NA";
      icon = "09d";
    }
  }
}
