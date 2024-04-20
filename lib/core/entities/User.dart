class Usuario {
  final String userName;
  final String password;

  Usuario({required this.userName, required this.password});
  
  
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
    };
  }
}

