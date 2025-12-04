
import 'package:json_annotation/json_annotation.dart';

part 'CriteriaValuForCategoryTypePermis.g.dart';

@JsonSerializable()
class CriteriaValuForCategoryTypePermis {
  final String  nomCategorie;
  final int  points;


  CriteriaValuForCategoryTypePermis(
     this.nomCategorie, this.points);

  factory CriteriaValuForCategoryTypePermis.fromJson(Map<String, dynamic> data)=>_$CriteriaValuForCategoryTypePermisFromJson(data);
  Map<String,dynamic> toJson() => _$CriteriaValuForCategoryTypePermisToJson(this);
}