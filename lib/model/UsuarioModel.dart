class UsuarioModel {
  dynamic id;
  String nome;
  String email;
  String token;
  String dataLogin;
  String ruc;
  dynamic documento;
  String telefone;
  dynamic providerId;
  bool error;
  String msg;

  UsuarioModel(
      {this.id,
      this.nome,
      this.email,
      this.token,
      this.dataLogin,
      this.ruc,
      this.documento,
      this.telefone,
      this.providerId,
      this.error,
      this.msg});

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
        id: json["id"],
        nome: json["nome"],
        email: json["email"],
        token: json["token"],
        dataLogin: json["dataLogin"],
        ruc: json["ruc"],
        documento: json["documento"],
        telefone: json["telefone"],
        providerId: json["providerId"],
        error: json["error"],
        msg: json["msg"]);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
        "email": email,
        "token": token,
        "dataLogin": dataLogin,
        "ruc": ruc,
        "documento": documento,
        "telefone": telefone,
        "providerId": providerId,
        "error": error,
        "msg": msg
      };
}
