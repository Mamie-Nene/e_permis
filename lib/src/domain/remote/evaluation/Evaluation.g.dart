// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Evaluation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Evaluation _$EvaluationFromJson(Map<String, dynamic> json) => Evaluation(

  numeroDossierCandidat: json['numeroDossierCandidat'] as String,
  inspecteurMatricule:  json['inspecteurMatricule'] as String,
  codeTypePermis:   json['codeTypePermis'] as String,
  commentaire:   json['commentaire'] as String,
  signatureInspecteur:  json['signatureInspecteur'] as String,
    resultat: ResultatCategoryTypePermis.fromJson(json['resultatsCategories'] as Map<String, dynamic>)

  /*resultatsCategories: (json['criteres'] as List<dynamic>)
    .map((e) =>
      ResultatCategoryTypePermis.fromJson(e as Map<String, dynamic>))
    .toList(),
*/
);

Map<String, dynamic> _$EvaluationToJson(Evaluation instance) => <String, dynamic>{

  'numeroDossierCandidat': instance.numeroDossierCandidat,
  'inspecteurMatricule': instance.inspecteurMatricule,
  'codeTypePermis': instance.codeTypePermis,
  'commentaire': instance.commentaire,
  'signatureInspecteur': instance.signatureInspecteur,
  'resultat': instance.resultat,

};