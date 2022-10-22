class AuthDataModel {
  final int login;
  final String password;

  AuthDataModel(this.login, this.password);

  Map<String, dynamic> toMap() => {
        'login': login,
        'password': password,
      };
}
