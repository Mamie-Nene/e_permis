// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResultatCategoryTypePermis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultatCategoryTypePermis _$ResultatCategoryTypePermisFromJson(Map<String, dynamic> json) => ResultatCategoryTypePermis(


    criteres:  (json['criteres'] as List<dynamic>)
        .map((e) =>
        CriteriaValuForCategoryTypePermis.fromJson(e as Map<String, dynamic>))
        .toList(),

);

Map<String, dynamic> _$ResultatCategoryTypePermisToJson(ResultatCategoryTypePermis instance) => <String, dynamic>{

  'criteres': instance.criteres,

};