class Subject {
  /// Internal code for this Subject.
  late final String code;

  /// Public facing description for this subject.
  late final String? description;

  Subject({required this.code, this.description});

  /// Excepts an entry from the EllucianApi.getSubjects() result.
  Subject.fromJson(Map<String, dynamic> input) {
    if (input["code"] != null) code = input["code"].toString();
    description = input["description"];
  }
}
