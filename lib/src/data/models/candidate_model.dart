
class Candidate {
  final String name;
  final String drivingSchool;
  final String licenseType;
  final String fileNumber;
  bool evaluated;

  Candidate({
    required this.name,
    required this.drivingSchool,
    required this.licenseType,
    required this.fileNumber,
    this.evaluated = false,
  });
}
