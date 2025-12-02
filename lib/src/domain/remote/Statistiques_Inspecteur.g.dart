// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Statistiques_Inspecteur.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Statistiques_Inspecteur _$Statistiques_InspecteurFromJson(Map<String, dynamic> json) => Statistiques_Inspecteur(

    json['inspecteurId']as String,
    json['dateCalcul']as String,
    json['nomComplet']as String,
    json['matricule']as String,
    json['totalCandidats']as int,
    json['candidatsAujourdhui']as int,
    json['totalEvaluations']as int,
    json['evaluationsAujourdhui']as int,
    json['admis']as int,
    json['ajoure']as int,
    json['tauxReussite']as double,
    json['tauxEchec']as double,
    json['tauxOccupation']as double,
    json['surcharge']as bool

);

Map<String, dynamic> _$Statistiques_InspecteurToJson(Statistiques_Inspecteur instance) => <String, dynamic>{

  'inspecteurId': instance.inspecteurId,
  'dateCalcul': instance.dateCalcul,
  'nomComplet': instance.nomComplet,
  'matricule': instance.matricule,
  'totalCandidats': instance.totalCandidats,
  'candidatsAujourdhui': instance.candidatsAujourdhui,
  'totalEvaluations': instance.totalEvaluations,
  'evaluationsAujourdhui': instance.evaluationsAujourdhui,
  'admis': instance.admis,
  'ajoure': instance.ajoure,
  'tauxReussite': instance.tauxReussite,
  'tauxEchec': instance.tauxEchec,
  'tauxOccupation': instance.tauxOccupation,
  'surcharge': instance.surcharge
};