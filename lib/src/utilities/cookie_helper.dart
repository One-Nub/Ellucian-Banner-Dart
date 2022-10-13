/// The only cookies we really care about is JSESSIONID and SSSA, need to parse those out.
///
/// These cookies only last for a session, so i'm not really worried about following the cookie
/// spec too closely.
///
/// There is also a tertiary cookie that may be of use, named IDMSESSID. I'm not sure what it is
/// used for, and I believe it only shows up on requests that require authentication (such as viewing your
/// schedule, registering for classes, etc).
Map<String, String> parseCookiesFromString(String input) {
  /// Only 2 cookies are JSESSONID and SSSA, comma split in the set-cookie header.
  List<String> majorCookieList = input.split(",");
  Map<String, String> output = {};

  for (var element in majorCookieList) {
    /// Not sure what this means, guessing minor splits containing additional data
    /// related to the major cookie. I should read up on the Cookie spec...
    List<String> minorCookieList = element.split(";");

    /// Since what we care about should be the first element, it is presumed safe to just take the first
    /// element of the minor list and add it to the output
    List<String> finalSplit = minorCookieList.first.split("=");
    output = {...output, finalSplit.first: finalSplit.last};
  }

  return output;
}
