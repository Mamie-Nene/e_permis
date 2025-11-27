import 'dart:convert';
import 'package:e_permis/src/domain/remote/Candidate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/src/utils/variable/global_variable.dart';
import '/src/utils/consts/app_specifications/all_directories.dart';


class CandidatApi{

  getListCandidatsByInspecteur(BuildContext context,String URL, String inspecteurId) async {
    List<Candidate> candidats=[];

    var uri = "$URL/$inspecteurId";
    try {
      print(uri);
      var response = await http.get(
          Uri.parse(uri),
      );
      debugPrint("response.statusCode for get List Candidats By Inspecteur ${response.statusCode}");
      debugPrint("response.body for get List Candidats By Inspecteur ${response.body}");

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

  getListCandidatsDuJourByInspecteurWithStatus(BuildContext context,String URL,String inspecteurId,bool estEvalue) async {
    List<Candidate> candidats=[];

    var uri = "$URL/$inspecteurId/planning-du-jour?estEvalue=$estEvalue";
    try {

      print(uri);
      var response = await http.get(
          Uri.parse(uri),
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

  getListCandidatsDuJourByInspecteurWithStatusAndTypePermis(BuildContext context,String URL,String inspecteurId,String permisId, bool estEvalue) async {
    List<Candidate> candidats=[];
    var uri = "$URL/$inspecteurId/planning-du-jour?estEvalue=$estEvalue&typePermis=$permisId";

    try {

      print(uri);
      var response = await http.get(
          Uri.parse(uri),
      );
      debugPrint("response.statusCode for get List Candidat by Inspecteur with status and type permis ${response.statusCode}");
      debugPrint("response.body for get List Candidat by Inspecteur with status and type permis ${response.body}");

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

  getCandidatDetails(BuildContext context,String candidatId, String URL) async {
    var uri = "$URL/$candidatId";

    try {

      print(uri);
      var response = await http.get(
          Uri.parse(uri),
      );
      debugPrint("response.statusCode for getDetailCandidat ${response.statusCode}");
      debugPrint("response.body for getDetailCandidat ${response.body}");

      if (response.statusCode == 200) {

        var data = json.decode(response.body);

          Candidate candidat = Candidate.fromJson(data);
          return candidat;

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

  rechercherCandidat(BuildContext context,String value, String URL) async {
    var uri = "$URL?q=$value";

    try {

      print(uri);
      var response = await http.get(
          Uri.parse(uri),
      );
      debugPrint("response.statusCode for recherche candidat ${response.statusCode}");
      debugPrint("response.body for recherche candidat ${response.body}");

      if (response.statusCode == 200) {

        var data = json.decode(response.body);

          Candidate candidat = Candidate.fromJson(data);
          return candidat;

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