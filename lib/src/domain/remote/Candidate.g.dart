// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Candidate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Candidate _$CandidateFromJson(Map<String, dynamic> json) => Candidate(

     json['id'] as String,
     json['nom'] as String,
     json['prenom'] as String,
     json['autoEcole'] as String,
     json['typePermis'] as String,
     json['numeroDossier'] as String,
     json['dateEvaluation'] as String,
     json['inspecteurId'] as String,
     json['motifReplanification']??"Aucun",
     json['dateReplanification']??"Aucun",
     json['dateCreation']??"Aucun",
     json['estEvalue'] as  bool,
     json['estReplanifie'] as  bool,

);

Map<String, dynamic> _$CandidateToJson(Candidate instance) => <String, dynamic>{

  'id': instance.id,
  'nom': instance.nom,
  'prenom': instance.prenom,
  'autoEcole': instance.autoEcole,
  'typePermis': instance.typePermis,
  'numeroDossier': instance.numeroDossier,
  'dateEvaluation': instance.dateEvaluation,
  'inspecteurId': instance.inspecteurId,
  'motifReplanification': instance.motifReplanification,
  'dateReplanification': instance.dateReplanification,
  'dateCreation': instance.dateCreation,
  'estEvalue': instance.estEvalue,
  'estReplanifie': instance.estReplanifie,
};