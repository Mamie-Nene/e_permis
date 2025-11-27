// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TypePermis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypePermis _$TypePermisFromJson(Map<String, dynamic> json) => TypePermis(

     json['id'] as String,
     json['code'] as String,
     json['libelle'] as String,
     json['description'] as String,
     json['actif'] as  bool

);

Map<String, dynamic> _$TypePermisToJson(TypePermis instance) => <String, dynamic>{

  'id': instance.id,
  'code': instance.code,
  'libelle': instance.libelle,
  'description': instance.description,
  'actif': instance.actif
};