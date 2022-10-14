class Term {
  /// Internal code for this Term.
  late final String code;

  /// Public facing descriptor for this Term.
  late final String? description;

  Term({required this.code, this.description});

  /// Excepts an entry from the EllucianApi.getTerms() result.
  Term.fromJson(Map<String, dynamic> input) {
    if (input["code"] != null) code = input["code"].toString();
    description = input["description"];
  }
}
