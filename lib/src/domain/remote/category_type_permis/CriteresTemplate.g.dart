// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CriteresTemplate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CriteresTemplate _$CriteresTemplateFromJson(Map<String, dynamic> json) => CriteresTemplate(

     criteres:(json['criteres'] as List<dynamic>)
         .map((e) => Critere.fromJson(e as Map<String, dynamic>))
         .toList(),


);

Map<String, dynamic> _$CriteresTemplateToJson(CriteresTemplate instance) => <String, dynamic>{

  'criteres': instance.criteres.map((e) => e.toJson()).toList(),
};