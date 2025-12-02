import 'dart:convert';
import 'package:e_permis/src/domain/remote/TypePermis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '/src/utils/variable/global_variable.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/utils/consts/app_specifications/all_directories.dart';


class PermisApi{

  getListPermis(String URL) async {
    List<TypePermis> permis=[];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if( token == null)
    {
      globalResponseMessage.errorMessage(AppText.ID_INSPECTEUR_NULL);
    }
    else {
      try {
      print(URL);
      final headers = {
        'Authorization': 'Bearer $token',
      };
      var response = await http.get(
        Uri.parse(URL),headers: headers
      );
      debugPrint("response.statusCode for get List permis ${response.statusCode}");
      debugPrint("response.body for get List permis ${response.body}");

      if (response.statusCode == 200) {
        List data = json.decode(response.body);

        if (data.isEmpty) {
          return permis;
        }
        permis = data.map((e)=>TypePermis.fromJson(e)).toList();
        return permis;

      }
      if (response.statusCode == 403) {
        print(response.statusCode);
        globalResponseMessage.errorMessage(AppText.TOKEN_HEADER_NULL);
      }
      else  {
        print(response.statusCode);
        globalResponseMessage.errorMessage("Une Erreur est survenue!");
      }
    }

    catch (e) {
      debugPrint("error throw: ${e.toString()}");
      globalResponseMessage.errorMessage(AppText.CATCH_ERROR_TEXT);
    }
    }

  }


}