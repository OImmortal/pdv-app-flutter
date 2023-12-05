class User {
  final String _email;
  final String _senha;
  final String _token;

  User({
    required String email,
    required String senha,
    required String token,
  })  : _email = email,
        _senha = senha,
        _token = token;

  String get getEmail {
    return _email;
  }

  String get getToken {
    return _token;
  }
}
