import 'dart:convert';

import 'package:zartek/Modals/restaurant_modal.dart';
import 'package:zartek/Services/api.dart';

class UserHomeRepo {

  Future getData() async {
    final response = await Http().get('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad');
    print(response.body);
    if(response.statusCode == 200) {
      final data = List<Restaurant>.from(jsonDecode(response.body).map((x) => Restaurant.fromJson(x)));
      return data;
      //return Restaurant.fromJson(jsonDecode(response.body));
    } else {
      return jsonDecode(response.body);
    }
  }
}