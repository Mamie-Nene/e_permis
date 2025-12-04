
import 'package:e_permis/src/domain/remote/category_type_permis/CriteresTemplate.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CategoryTypePermis.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoryTypePermis {
  final String id;
  final String nom;
  final String typePermis;
  final CriteresTemplate criteresTemplate;
  final int? score;
  final int scoreMax;
  final double? pourcentage;
  final bool? valide;


  CategoryTypePermis({
  required this.id,
  required this.nom,
  required this.typePermis,
  required this.criteresTemplate,
      required this.score,
  required this.scoreMax,
  required this.pourcentage,
  required this.valide
  });

  factory CategoryTypePermis.fromJson(Map<String, dynamic> data)=>_$CategoryTypePermisFromJson(data);
  Map<String,dynamic> toJson() => _$CategoryTypePermisToJson(this);
}