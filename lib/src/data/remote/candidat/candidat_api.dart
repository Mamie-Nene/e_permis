import 'dart:convert';
import 'package:e_permis/src/domain/remote/Candidate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '/src/utils/variable/global_variable.dart';
import '/src/utils/consts/app_specifications/all_directories.dart';


class CandidatApi{

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