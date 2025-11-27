
import 'package:json_annotation/json_annotation.dart';

part 'Candidate.g.dart';

@JsonSerializable()
class Candidate {
  final String id,nom,prenom,autoEcole,typePermis;
  final String numeroDossier,dateEvaluation,inspecteurId;
  final String? motifReplanification,dateReplanification,dateCreation;
  bool estEvalue,estReplanifie;


  Candidate(
      this.id,
      this.nom,
      this.prenom,
      this.autoEcole,
      this.typePermis,
      this.numeroDossier,
      this.dateEvaluation,
      this.inspecteurId,
      this.motifReplanification,
      this.dateReplanification,
      this.dateCreation,
      this.estEvalue,
      this.estReplanifie);

  factory Candidate.fromJson(Map<String, dynamic> data)=>_$CandidateFromJson(data);
  Map<String,dynamic> toJson() => _$CandidateToJson(this);
}