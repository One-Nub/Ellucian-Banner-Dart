class UriBuilder {
  String? scheme;
  String? userInfo;
  String? host;
  int? port;
  String? path;
  Iterable<String>? pathSegments;
  String? query;
  Map<String, dynamic>? queryParameters;
  String? fragment;

  UriBuilder(
      {this.scheme,
      this.userInfo,
      this.host,
      this.port,
      this.path,
      this.pathSegments,
      this.query,
      this.queryParameters,
      this.fragment});

  void setScheme(String scheme) => this.scheme = scheme;

  void setUserInfo(String userInfo) => this.userInfo = userInfo;

  void setHost(String host) => this.host = host;

  void setPort(int port) => this.port = port;

  void setPath(String path) => this.path = path;

  void setPathSegments(Iterable<String> pathSegments) => this.pathSegments = pathSegments;

  void setQuery(String query) => this.query = query;

  void setQueryParameters(Map<String, dynamic> queryParameters) => this.queryParameters = queryParameters;

  void setFragment(String fragment) => this.fragment;

  Uri build() {
    return Uri(
        scheme: scheme,
        userInfo: userInfo,
        host: host,
        port: port,
        path: path,
        pathSegments: pathSegments,
        query: query,
        queryParameters: queryParameters,
        fragment: fragment);
  }
}
