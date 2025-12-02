// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Inspecteur.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inspecteur _$InspecteurFromJson(Map<String, dynamic> json) => Inspecteur(

     json['id'] as String,
     json['nom'] as String,
     json['prenom'] as String,
     json['matricule'] as String,
     json['username'] as String,
     json['telephone'] as String,
     json['statut'] as  String,
     json['grade'] as String,
     json['zoneAffectation'] as String,
     json['email'] as String,

);

Map<String, dynamic> _$InspecteurToJson(Inspecteur instance) => <String, dynamic>{

  'id': instance.id,
  'nom': instance.nom,
  'prenom': instance.prenom,
  'matricule': instance.matricule,
  'username': instance.username,
  'telephone': instance.telephone,
  'statut': instance.statut,
  'grade': instance.grade,
  'zoneAffectation': instance.zoneAffectation,
  'email': instance.email,
};