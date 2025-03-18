class SignupReqParams {
  final String email;
  final String password;
  final String username;
  final List<String> role;

  SignupReqParams({
    required this.email,
    required this.password,
    required this.username,
    this.role = const ['ROLE_USER'],
  });
  //converting model to JSON Format in order to send as a HTTP Request
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'username': username,
      'role': role,
    };
  }
}

enum ERole { ROLE_USER, ROLE_MODERATOR, ROLE_ADMIN }
