
import 'package:json_annotation/json_annotation.dart';

part 'Statistiques_Inspecteur.g.dart';

@JsonSerializable()
class Statistiques_Inspecteur {
  final String inspecteurId, dateCalcul,nomComplet,matricule;
  final int totalCandidats, candidatsAujourdhui, totalEvaluations, evaluationsAujourdhui, admis, ajoure;
  final double tauxReussite, tauxEchec, tauxOccupation;
  bool surcharge;

  Statistiques_Inspecteur(
      this.inspecteurId,
      this.dateCalcul,
      this.nomComplet,
      this.matricule,
      this.totalCandidats,
      this.candidatsAujourdhui,
      this.totalEvaluations,
      this.evaluationsAujourdhui,
      this.admis,
      this.ajoure,
      this.tauxReussite,
      this.tauxEchec,
      this.tauxOccupation,
      this.surcharge);

  factory Statistiques_Inspecteur.fromJson(Map<String, dynamic> data)=>_$Statistiques_InspecteurFromJson(data);
  Map<String,dynamic> toJson() => _$Statistiques_InspecteurToJson(this);
}


