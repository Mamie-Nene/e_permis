
import 'package:e_permis/src/domain/remote/evaluation/CriteriaValuForCategoryTypePermis.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ResultatCategoryTypePermis.g.dart';

@JsonSerializable()
class ResultatCategoryTypePermis {
  List<CriteriaValuForCategoryTypePermis>criteres;


  ResultatCategoryTypePermis( {required this.criteres } );


  factory ResultatCategoryTypePermis.fromJson(Map<String, dynamic> data)=>_$ResultatCategoryTypePermisFromJson(data);
  Map<String,dynamic> toJson() => _$ResultatCategoryTypePermisToJson(this);
}