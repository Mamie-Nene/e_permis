
import 'package:json_annotation/json_annotation.dart';

part 'TypePermis.g.dart';

@JsonSerializable()
class TypePermis {
  final String id,code,libelle,description;
  bool actif;

 // "categoriesTemplate": "string",


  TypePermis(
      this.id,
      this.code,
      this.libelle,
      this.description,
      this.actif);

  factory TypePermis.fromJson(Map<String, dynamic> data)=>_$TypePermisFromJson(data);
  Map<String,dynamic> toJson() => _$TypePermisToJson(this);
}