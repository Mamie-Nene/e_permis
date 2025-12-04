import 'dart:convert';
import 'package:e_permis/src/domain/remote/TypePermis.dart';
import 'package:e_permis/src/domain/remote/category_type_permis/CategoryTypePermis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '/src/utils/variable/global_variable.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/utils/consts/app_specifications/all_directories.dart';


class CategoryTypePermisApi{

  getListCategoryPermis(String URL, String typePermis) async {
    List<CategoryTypePermis> categoryTypePermis=[];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if( token == null)
    {
      globalResponseMessage.errorMessage(AppText.ID_INSPECTEUR_NULL);
      return;
    }
    else {
      var uri = "$URL/$typePermis";
      try {
      print(uri);
      final headers = {
        'Authorization': 'Bearer $token',
      };
      var response = await http.get(
        Uri.parse(uri),headers: headers
      );
      debugPrint("response.statusCode for get catgeory List permis ${response.statusCode}");
      debugPrint("response.body for get catgeory List permis ${response.body}");

      if (response.statusCode == 200) {
        List data = json.decode(response.body);

        if (data.isEmpty) {
          return categoryTypePermis;
        }
        categoryTypePermis = data.map((e)=>CategoryTypePermis.fromJson(e)).toList();
        return categoryTypePermis;

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