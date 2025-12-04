
import 'package:e_permis/src/domain/remote/evaluation/ResultatCategoryTypePermis.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Evaluation.g.dart';

@JsonSerializable()
class Evaluation {
  final String numeroDossierCandidat,inspecteurMatricule,codeTypePermis,commentaire,signatureInspecteur;
  final ResultatCategoryTypePermis resultat;


  Evaluation({
    required this.numeroDossierCandidat,
    required this.inspecteurMatricule,
    required this.codeTypePermis,
    required this.commentaire,
    required this.signatureInspecteur,
    required this.resultat
  });

  factory Evaluation.fromJson(Map<String, dynamic> data)=>_$EvaluationFromJson(data);
  Map<String,dynamic> toJson() => _$EvaluationToJson(this);
}