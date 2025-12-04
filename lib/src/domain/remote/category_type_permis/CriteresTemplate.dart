
import 'package:e_permis/src/domain/remote/category_type_permis/Critere.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CriteresTemplate.g.dart';

@JsonSerializable(explicitToJson: true)
class CriteresTemplate {
  final List<Critere> criteres;

  CriteresTemplate({required this.criteres});


  factory CriteresTemplate.fromJson(Map<String, dynamic> data)=>_$CriteresTemplateFromJson(data);
  Map<String,dynamic> toJson() => _$CriteresTemplateToJson(this);
}