import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '/src/utils/variable/global_variable.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/utils/consts/app_specifications/all_directories.dart';


class AuthApi{
  loginRequest(BuildContext context,String matriculeOrUsername, String password, String URL) async {

    try {
      String token="";
      String matriculeInspecteur="";
      String idInspecteur="";

      print(URL);

      var response = await http.post(
          Uri.parse(URL),
          headers: {
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            'login': matriculeOrUsername,
            'password': password,
          })
      );
      debugPrint("response.statusCode for getToken after login ${response.statusCode}");
      debugPrint("response.body for getToken after login ${response.body}");

      if (response.statusCode == 200) {

        print(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
          var data = json.decode(response.body);
          token = data['token'];
          matriculeInspecteur = data['matricule'];
          idInspecteur = data['userId'];

          prefs.setString("token", token);
          prefs.setString("matriculeInspecteur", matriculeInspecteur);
          prefs.setString("idInspecteur", idInspecteur);
          prefs.setBool("isLoggedIn", true);

          globalResponseMessage.successMessage("Connexion réussie !!");

          if(context.mounted) {
            return Navigator.of(context).pushReplacementNamed(AppRoutesName.inspectorHome);
          }

      }

      else  {//400
        print(response.statusCode);
        globalResponseMessage.errorMessage("Identifiant ou mot de passe invalide !! ");

      }
    }

    catch (e) {
      debugPrint("error throw: ${e.toString()}");
      globalResponseMessage.errorMessage(AppText.CATCH_ERROR_TEXT);
    }

  }
}