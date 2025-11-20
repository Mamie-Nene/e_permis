import 'package:e_permis/src/data/models/candidate_model.dart';
import 'package:e_permis/src/presentation/pages/inspection_dashboard_page.dart';
import 'package:e_permis/src/presentation/screens/candidate_selection/candidate_selection_screen.dart';
import 'package:e_permis/src/presentation/screens/confirmation/confirmation_screen.dart';
import 'package:e_permis/src/presentation/screens/evaluation_form/evaluation_form_screen.dart';
import 'package:e_permis/src/presentation/screens/evaluation_result/evaluation_result_screen.dart';
import 'package:e_permis/src/presentation/screens/profile/inspector_profile_screen.dart';
import 'package:e_permis/src/presentation/screens/signature/signature_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_permis/src/presentation/screens/login/login_screen.dart';
import 'package:e_permis/src/presentation/screens/home/home_screen.dart';
import 'package:e_permis/src/presentation/screens/candidate_details/candidate_details_screen.dart';
import 'package:e_permis/src/utils/consts/routes/app_routes_name.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.inspectorLogin:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case AppRoutesName.inspectorHome:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case AppRoutesName.inspectorProfile:
        return MaterialPageRoute(
            builder: (context) => const InspectorProfileScreen());

      case AppRoutesName.candidateSelection:
        return MaterialPageRoute(
            builder: (context) => const CandidateSelectionScreen());

      case AppRoutesName.candidateDetails:
        if (settings.arguments is Candidate) {
          final candidate = settings.arguments as Candidate;
          return MaterialPageRoute(
              builder: (context) =>
                  CandidateDetailsScreen(candidate: candidate));
        }
        return _errorRoute();

      case AppRoutesName.evaluationForm:
        return MaterialPageRoute(
            builder: (context) => const EvaluationFormScreen());

      case AppRoutesName.evaluationResult:
        if (settings.arguments is EvaluationResult) {
          final result = settings.arguments as EvaluationResult;
          return MaterialPageRoute(
              builder: (context) => EvaluationResultScreen(result: result));
        }
        return _errorRoute();

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
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }
}
