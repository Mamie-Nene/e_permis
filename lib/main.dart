import 'dart:io';

import 'package:e_permis/src/config/router/route_generator.dart';
import 'package:e_permis/src/utils/consts/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:e_permis/src/utils/consts/app_specifications/app_theme.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e-Permis Inspecteur',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialRoute: AppRoutesName.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
