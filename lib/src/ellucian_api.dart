import 'dart:convert';

import 'package:http/http.dart' as http;

import 'utilities/cookie_helper.dart';
import 'utilities/uri_builder.dart';

class EllucianApi {
  final String _scheme = "https";
  String _host = "";
  final String _basePath = "StudentRegistrationSsb/ssb";

  final String _getTerms = "/classSearch/getTerms";
  final String _getSubjects = "/classSearch/get_subject";
  final String _resetForm = "/classSearch/resetDataForm";
  final String _searchResults = "/searchResults/searchResults";
  final String _termSet = "/term/search";

  final Map<String, String> cookieMap = {"Cookie": ""};

  EllucianApi({String? host}) {
    if (host != null) _host = host;
  }

  /// Get a list of the latest 10 terms optionally named similarly to [query].
  Future<List<dynamic>> getTerms({String? query}) async {
    Map<String, dynamic> body = {"offset": 1, "max": 10, "searchTerm": query ??= ""};
    UriBuilder builder =
        UriBuilder(scheme: _scheme, host: _host, path: "$_basePath$_getTerms", queryParameters: body);

    http.Response response = await http.get(builder.build(), headers: cookieMap);
    if (response.headers.containsKey("set-cookie")) {
      _updateCookieMap(response.headers["set-cookie"]!);
    }

    return jsonDecode(response.body);
  }

  /// Get a list of 10 subjects optionally based upon [query] for the [term].
  Future<List<dynamic>> getSubjects({required String term, String? query}) async {
    Map<String, dynamic> queryParameters = {"term": term, "offset": 1, "max": 10, "searchTerm": query ??= ""};
    UriBuilder builder = UriBuilder(
        scheme: _scheme, host: _host, path: "$_basePath$_getSubjects", queryParameters: queryParameters);

    http.Response response = await http.get(builder.build(), headers: cookieMap);
    if (response.headers.containsKey("set-cookie")) {
      _updateCookieMap(response.headers["set-cookie"]!);
    }

    return jsonDecode(response.body);
  }

  /// Tells the server to reset the search query form, since it is cached. Necessary for searching for
  /// a different subject or course number after a prior search.
  Future<bool> resetSearchForm() async {
    UriBuilder builder = UriBuilder(scheme: _scheme, host: _host, path: "$_basePath$_resetForm");

    http.Response response = await http.post(builder.build(),
        headers: {...cookieMap, "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"});
    if (response.headers.containsKey("set-cookie")) {
      _updateCookieMap(response.headers["set-cookie"]!);
    }

    return response.body == "true";
  }

  /// Search for classes based upon any variety of the accepted parameters (term, subject, course number, etc).
  Future<List<dynamic>> searchForClasses(
      {required String term,
      String? subject,
      String? courseNumber,
      int pageMaxSize = 10,
      int pageOffset = 1,
      Map<String, dynamic>? additional_queries}) async {
    Map<String, dynamic> queryParameters = {
      "txt_term": term,
      "pageOffset": pageOffset.toString(),
      "pageMaxSize": pageMaxSize.toString()
    };
    if (subject != null) queryParameters["txt_subject"] = subject;
    if (courseNumber != null) queryParameters["txt_courseNumber"] = courseNumber;
    if (additional_queries != null) {
      for (var key in additional_queries.keys) {
        queryParameters.putIfAbsent(key, () => additional_queries[key].toString());
      }
    }

    UriBuilder builder = UriBuilder(
        scheme: _scheme, host: _host, path: "$_basePath$_searchResults", queryParameters: queryParameters);

    http.Response response =
        await http.get(builder.build(), headers: {...cookieMap, "Accept": "application/json"});
    if (response.headers.containsKey("set-cookie")) {
      _updateCookieMap(response.headers["set-cookie"]!);
    }

    var body = jsonDecode(response.body);
    if (body["data"] == null) {
      /// add logging package and complain?
      return [];
    } else {
      return body["data"];
    }
  }

  /// Sends a POST request to set the term for which the consequential course search requests will be utilizing.
  ///
  /// I found out this was necessary after stumbling across the documentation some other students made regarding the
  /// Ellucian Banner API for [their college](https://jennydaman.gitlab.io/nubanned/dark.html#studentregistrationssb-search-get).
  ///
  /// No response is returned since it's always a 200 response, invalid term numbers don't error either.
  Future<void> postSearchTerm(String term) async {
    UriBuilder builder = UriBuilder(scheme: _scheme, host: _host, path: "$_basePath$_termSet");

    http.Response response = await http.post(builder.build(),
        body: {"term": term}, headers: {...cookieMap, "Content-Type": "application/x-www-form-urlencoded"});
    if (response.headers.containsKey("set-cookie")) {
      _updateCookieMap(response.headers["set-cookie"]!);
    }
  }

  void _updateCookieMap(String cookieHeader) {
    var mapRepresentation = parseCookiesFromString(cookieHeader);
    String result = "";
    for (var element in mapRepresentation.keys) {
      result += "$element=${mapRepresentation[element]};";
    }

    cookieMap["Cookie"] = result;
  }
}
