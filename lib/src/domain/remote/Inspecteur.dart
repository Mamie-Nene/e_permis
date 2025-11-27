
import 'package:json_annotation/json_annotation.dart';

part 'Inspecteur.g.dart';

@JsonSerializable()
class Inspecteur {
  final String id,nom,prenom,matricule,username, telephone;
  bool statut;



  Inspecteur(
      this.id,
      this.nom,
      this.prenom,
      this.matricule,
      this.username,
      this.telephone,
      this.statut);

  factory Inspecteur.fromJson(Map<String, dynamic> data)=>_$InspecteurFromJson(data);
  Map<String,dynamic> toJson() => _$InspecteurToJson(this);
}