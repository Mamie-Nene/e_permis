import 'dart:convert';
import 'package:e_permis/src/domain/remote/Inspecteur.dart';
import 'package:e_permis/src/domain/remote/Statistiques_Inspecteur.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '/src/utils/variable/global_variable.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/utils/consts/app_specifications/all_directories.dart';


class InspecteurApi{

  getInspecteurDetails(BuildContext context,String inspecteurId, String URL) async {
    var uri = "$URL/$inspecteurId";

    try {

      print(uri);
      var response = await http.get(
        Uri.parse(uri),
      );
      debugPrint("response.statusCode for getDetailCandidat ${response.statusCode}");
      debugPrint("response.body for getDetailCandidat ${response.body}");

      if (response.statusCode == 200) {

        var data = json.decode(response.body);

        Inspecteur inspecteur = Inspecteur.fromJson(data);
        return inspecteur;

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

  statistiqueInspecteur(BuildContext context,String inspecteurId, String URL) async {
    var uri = "$URL/$inspecteurId/dashboard";

    try {

      print(uri);
      var response = await http.get(
        Uri.parse(uri),
      );
      debugPrint("response.statusCode for stats inspecteurs ${response.statusCode}");
      debugPrint("response.body for stats inspecteurs ${response.body}");

      if (response.statusCode == 200) {

        var data = json.decode(response.body);
        var statistiques = data["statistiques"];

        Statistiques_Inspecteur inspecteurStats = Statistiques_Inspecteur.fromJson(statistiques);
        return inspecteurStats;
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