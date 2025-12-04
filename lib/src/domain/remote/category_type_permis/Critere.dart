
import 'package:json_annotation/json_annotation.dart';

part 'Critere.g.dart';

@JsonSerializable()
class Critere {
  final String nom;
  final int points;

  Critere({required this.nom, required this.points});
  factory Critere.fromJson(Map<String, dynamic> data)=>_$CritereFromJson(data);
  Map<String,dynamic> toJson() => _$CritereToJson(this);
}