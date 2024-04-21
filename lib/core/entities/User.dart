class Usuario {
  final String userName;
  final String password;
  final String mail;
  
  Usuario({required this.mail, required this.userName, required this.password});
  
  
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
    };
  }

  String getUser(){
    return userName;
  }

  String getPassword(){
    return password;
  }
  
  String getMail(){
    return mail;
  }
}

