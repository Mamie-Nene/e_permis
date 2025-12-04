class ApiUrl {
  //              ---------------------- Const Var ----------------------
  static const String baseUrl = 'https://gupe-partenaire.gainde2000.sn/epermis-backend/api'; // Change this to your API URL
  static const String baseLocal = 'http://localhost//epermis-backend/api'; // Change this to your API URL

  //              ---------------------- Auth ----------------------
  String getLoginUrl = '$baseUrl/auth/login';

  //              ---------------------- Candidats ----------------------
  String getListCandidatsByInspecteurUrl = '$baseUrl/candidats/inspecteur';

  String monPlanningUrl = '$baseUrl/candidats/mon-planning';

  String getListCandidatsDuJourByInspecteurWithStatutUrl = '$baseUrl/candidats/inspecteur';

  String getListCandidatsDuJourByInspecteurWithStatutAndTypePermisUrl = '$baseUrl/candidats/inspecteur';

  String getDetailsCandidatUrl = '$baseUrl/candidats';

  String rechercherCandidatUrl = '$baseUrl/candidats/recherche';

  //              ---------------------- Inspecteurs ----------------------
  String getDetailsInspecteurUrl = '$baseUrl/users';

  String getStatistiquesInspecteurUrl = '$baseUrl/inspecteurs';

  //              ---------------------- App Routes ----------------------
  String getPlanningInspecteurUrl = '$baseUrl/inspecteurs/b1ea905e-124b-4631-893e-14d7829bd9af/planning-du-jour';

  //              ---------------------- Evaluations ----------------------
  String saveEvaluationCandidatUrl = '$baseUrl/new-evaluations';

  //              ---------------------- Permis ----------------------
  String getTypePermisUrl = '$baseUrl/types-permis';

  String getCategoryTypePermisUrl = '$baseUrl/categorie-evaluation-permis/allBy';
  String getCategoryTypePermisUrl1 = '$baseUrl/categorie-evaluation-permis';

}