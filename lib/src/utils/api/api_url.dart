class ApiUrl {
  //              ---------------------- Const Var ----------------------
  static const String baseUrl = 'https://gupe-partenaire.gainde2000.sn/epermis-backend/api'; // Change this to your API URL

  //              ---------------------- App Routes ----------------------
  String getLoginUrl = '$baseUrl/auth/login';

  //              ---------------------- App Routes ----------------------
  String getListCandidatsByInspecteurUrl = '$baseUrl/candidats/inspecteur';

  String getListCandidatsDuJourByInspecteurWithStatutUrl = '$baseUrl/candidats/inspecteur';

  String getListCandidatsDuJourByInspecteurWithStatutAndTypePermisUrl = '$baseUrl/candidats/inspecteur';

  String getDetailCandidatUrl = '$baseUrl/candidats';

  String rechercherCandidatUrl = '$baseUrl/candidats/recherche';

  //              ---------------------- App Routes ----------------------
  String getDetailInspecteurUrl = '$baseUrl/inspecteurs';
  String statistiquesInspecteurUrl = '$baseUrl/inspecteurs';

  //              ---------------------- App Routes ----------------------
  String getPlanningInspecteurUrl = '$baseUrl/inspecteurs/b1ea905e-124b-4631-893e-14d7829bd9af/planning-du-jour';

  //              ---------------------- App Routes ----------------------
  String getEvaluationByCandidatUrl = '$baseUrl/auth/auth';

  //              ---------------------- App Routes ----------------------
  String getTypePermisUrl = '$baseUrl/auth/auth';

}