import 'package:school_banner/school_banner.dart';

class BannerAPI {
  final EllucianApi ellucianApi;

  BannerAPI({required this.ellucianApi});

  Future<List<Term>> getTermList({String? query}) async {
    var termList = await ellucianApi.getTerms(query: query);
    List<Term> output = [];

    for (var element in termList) {
      Term term = Term.fromJson(element);
      output.add(term);
    }

    return output;
  }

  Future<List<Subject>> getSubjectList({required Term term, String? query}) async {
    List<Subject> output = [];
    var subjectList = await ellucianApi.getSubjects(term: term.code, query: query);
    for (var element in subjectList) {
      Subject subject = Subject.fromJson(element);
      output.add(subject);
    }

    return output;
  }

  Future<List<Course>> courseSearch(
      {required Term term,
      Subject? subject,
      String? courseNumber,
      int pageMaxSize = 10,
      int pageOffset = 1,
      bool showOnlyOpen = false,
      Map<String, dynamic>? additionalQueries}) async {
    List<Course> output = [];

    /// Instead of keeping state, we're just going to reset the search form and post the term
    /// every time a course search is performed :)
    ///
    /// In theory it should be fine, although the site probably won't appreciate it. For a nicer
    /// way of doing it, state should be tracked from the prior query so you know if you should
    /// post the term or reset the form.
    await ellucianApi.resetSearchForm();
    await ellucianApi.postSearchTerm(term.code);

    String? subjectCode;
    if (subject != null) subjectCode = subject.code;

    if (showOnlyOpen) {
      if (additionalQueries != null) {
        additionalQueries.addAll({"chk_open_only": showOnlyOpen});
      }
      additionalQueries ??= {"chk_open_only": showOnlyOpen};
    }

    var queryResult = await ellucianApi.searchForClasses(
        term: term.code,
        subject: subjectCode,
        courseNumber: courseNumber,
        pageMaxSize: pageMaxSize,
        pageOffset: pageOffset,
        additional_queries: additionalQueries);

    for (var element in queryResult) {
      Course course = Course.fromJson(element);
      output.add(course);
    }

    return output;
  }
}
