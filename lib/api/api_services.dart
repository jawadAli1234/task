// ignore_for_file: avoid_print, unused_local_variable, avoid_init_to_null

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:interviewtask/model/businees_model.dart';

class ApiServices {
  static Future<BusinessModel> getBusinessDetails() async {
    var businessModel = null;
    var headers = {
      "accept": "application/json",
      "Content-type": "application/json"
    };

    final response = await http.get(
      Uri.parse(
          'https://teletraan.co/api/service-provider-profile?pagination=true&user_detail=true&is_approved=approved&filter_by_top_providers=true&filter_by_service=drain-repair&zip=10501&from_explore=true'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var jsonParsed = json.decode(response.body);
      var businessModel = BusinessModel.fromJson(jsonParsed);
      print(businessModel.data.iterator);
      return businessModel;
    } else {
      return businessModel;
    }
  }
}
