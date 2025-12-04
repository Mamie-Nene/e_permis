// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CategoryTypePermis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryTypePermis _$CategoryTypePermisFromJson(Map<String, dynamic> json) => CategoryTypePermis(

  id: json['id'] as String,
  nom: json['nom'] as String,
  typePermis: json['typePermis'] as String,
  criteresTemplate: CriteresTemplate.fromJson(
      json['criteresTemplate'] as Map<String, dynamic>),
  score: json['score'] as int?,
  scoreMax: json['scoreMax'] as int,
  pourcentage: (json['pourcentage'] as num?)?.toDouble(),
  valide: json['valide'] as bool?,

);

Map<String, dynamic> _$CategoryTypePermisToJson(CategoryTypePermis instance) => <String, dynamic>{

  'id': instance.id,
  'nom': instance.nom,
  'typePermis': instance.typePermis,
  'criteresTemplate': instance.criteresTemplate.toJson(),
  'score': instance.score,
  'scoreMax': instance.scoreMax,
  'pourcentage': instance.pourcentage,
  'valide': instance.valide,
};