import 'dart:convert';
import 'package:e_permis/src/domain/remote/Candidate.dart';
import 'package:e_permis/src/domain/remote/Inspecteur.dart';
import 'package:e_permis/src/domain/remote/Statistiques_Inspecteur.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '/src/utils/variable/global_variable.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/utils/consts/app_specifications/all_directories.dart';


class InspecteurApi{

  getInspecteurDetails( String URL) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? inspecteurId = prefs.getString("idInspecteur");
    String? token = prefs.getString("token");

    if(inspecteurId==null||token==null)
    {
      globalResponseMessage.errorMessage(AppText.ID_INSPECTEUR_NULL);
      return;
    }
    else {
      var uri = "$URL/$inspecteurId";
      final headers = {
        'Authorization': 'Bearer $token',
      };
      try {
        print(uri);
        var response = await http.get(
          Uri.parse(uri),headers: headers
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

  }

  getStatistiquesInspecteur( String URL) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? matriculeInspecteur = prefs.getString("matriculeInspecteur");

    String? token = prefs.getString("token");

    if(matriculeInspecteur==null||token==null)
    {
      globalResponseMessage.errorMessage(AppText.ID_INSPECTEUR_NULL);
      return;
    }
    else {
      var uri = "$URL/$matriculeInspecteur/dashboard";
      final headers = {
        'Authorization': 'Bearer $token',
      };
      try {

        print(uri);
        var response = await http.get(
          Uri.parse(uri),headers: headers
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
  monPlanning( String URL) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? matriculeInspecteur = prefs.getString("matriculeInspecteur");
    String? token = prefs.getString("token");

    List<Candidate> candidats=[];

    if(matriculeInspecteur==null|| token ==null)
    {
      globalResponseMessage.errorMessage(AppText.ID_INSPECTEUR_NULL);
      return;
    }
    else {
      //?estEvalue=$estEvalue
      var uri = "$URL?date=2025-12-04";
      final headers = {
        'Authorization': 'Bearer $token',
      };
      try {

        print(uri);
        var response = await http.get(
          Uri.parse(uri),headers: headers
        );
        debugPrint("response.statusCode for get List Candidat by inspecteur et status ${response.statusCode}");
        debugPrint("response.body for get List Candidat by inspecteur et status ${response.body}");

        if (response.statusCode == 200) {

          List data = json.decode(response.body);

          if (data.isEmpty) {
            return candidats;
          }
          candidats = data.map((e)=>Candidate.fromJson(e)).toList();
          return candidats;

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