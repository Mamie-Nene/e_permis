import 'dart:convert';
import 'package:e_permis/src/domain/remote/Candidate.dart';
import 'package:e_permis/src/domain/remote/Inspecteur.dart';
import 'package:e_permis/src/domain/remote/Statistiques_Inspecteur.dart';
import 'package:e_permis/src/domain/remote/evaluation/Evaluation.dart';
import 'package:e_permis/src/domain/remote/evaluation/ResultatCategoryTypePermis.dart';
import 'package:e_permis/src/presentation/screens/evaluation/evaluation_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '/src/utils/variable/global_variable.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/utils/consts/app_specifications/all_directories.dart';


class EvaluationApi{

  saveEvaluation(String URL,EvaluationResult evaluationResult, String signatureInspecteur, BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? matriculeInspecteur = prefs.getString("matriculeInspecteur");
    String? token = prefs.getString("token");

    if(matriculeInspecteur==null||token==null)
    {
      globalResponseMessage.errorMessage(AppText.ID_INSPECTEUR_NULL);
      return;
    }
    else {
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      Evaluation evaluationCandidat = new Evaluation(
          numeroDossierCandidat: evaluationResult.numeroDossierCandidat,
          inspecteurMatricule: matriculeInspecteur,
          codeTypePermis: evaluationResult.typePermis,
          commentaire: evaluationResult.comments,
          signatureInspecteur: signatureInspecteur,
          resultat: ResultatCategoryTypePermis(criteres: evaluationResult.categories)
      );

    print(evaluationCandidat.toJson(),);
     try {
        print(URL);
        var response = await http.post(
            Uri.parse(URL),
            headers: headers,
          body: jsonEncode(
            evaluationCandidat.toJson(),
          )
        );
        debugPrint("response.statusCode for saveEvaluation ${response.statusCode}");
        debugPrint("response.body for saveEvaluation ${response.body}");

        if (response.statusCode == 200) {

          Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutesName.confirmation,
                    (Route<dynamic> route) => false,
                  );

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