class Token {
  String accessToken;
  String refreshToken;

  Token.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        refreshToken = json['refreshToken'];

  Token.zero()
      : refreshToken = '',
        accessToken = '';

  Map<String, String> toJson() =>
      {'accessToken': accessToken, 'refreshToken': refreshToken};

  void copy(Token token) {
    accessToken = token.accessToken;
    refreshToken = token.refreshToken;
  }
}
