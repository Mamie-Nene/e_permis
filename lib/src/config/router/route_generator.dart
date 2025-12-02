import '/src/presentation/screens/utils_pages/error_screen.dart';
import 'package:flutter/material.dart';

import '/src/domain/remote/Candidate.dart';

import '/src/presentation/screens/auth/inspector_profile_screen.dart';
import '/src/presentation/screens/auth/login_screen.dart';
import '/src/presentation/screens/home/inspector_home.dart';
import '/src/presentation/screens/home/splash_screen.dart';

import '/src/presentation/screens/candidat/candidate_selection_screen.dart';
import '/src/presentation/screens/candidat/candidate_details_screen.dart';

import '/src/presentation/screens/evaluation/confirmation_screen.dart';
import '/src/presentation/screens/evaluation/evaluation_form_screen.dart';
import '/src/presentation/screens/evaluation/evaluation_result_screen.dart';
import '/src/presentation/screens/evaluation/signature_screen.dart';

import '/src/utils/consts/routes/app_routes_name.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case AppRoutesName.inspectorLogin:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case AppRoutesName.inspectorHome:
        return MaterialPageRoute(builder: (context) => const InspectorHome());

      case AppRoutesName.inspectorProfile:
        return MaterialPageRoute(
            builder: (context) => const InspectorProfileScreen());

      case AppRoutesName.candidateSelection:
        return MaterialPageRoute(
            builder: (context) => const CandidateSelectionScreen());

      case AppRoutesName.candidateDetails:
        final args = settings.arguments;
        //if (settings.arguments is Candidate) {
          final candidate = args as Candidate;
          return MaterialPageRoute(builder: (context) => CandidateDetailsScreen(candidate: candidate));
        /*}
        return _errorRoute();*/

      case AppRoutesName.evaluationForm:
        return MaterialPageRoute(
            builder: (context) => const EvaluationFormScreen());

      case AppRoutesName.evaluationResult:
       // if (settings.arguments is EvaluationResult) {
          final args = settings.arguments;
          final result = args as EvaluationResult;
          return MaterialPageRoute(
              builder: (context) => EvaluationResultScreen(result: result));
        /*}
        return _errorRoute();*/

      case AppRoutesName.signature:
        return MaterialPageRoute(builder: (context) => const SignatureScreen());

      case AppRoutesName.confirmation:
        return MaterialPageRoute(
            builder: (context) => const ConfirmationScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context){
        return const ErrorScreen();
      }
    );
  }
}
