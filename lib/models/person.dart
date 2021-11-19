import 'dart:convert';


class Person {
  String? name;
  String? email;
  String? nickname;
  String? logradouro;
  String? bairro;
  String? localidade;
  String? uf;

  Person(
      {this.name,
      this.email,
      this.nickname,
      this.logradouro,
      this.bairro,
      this.localidade,
      this.uf});

  factory Person.fromJson(String string) => Person.fromMap(jsonDecode(string));

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        logradouro: json['logradouro'],
        bairro: json['bairro'],
        localidade: json['localidade'],
        uf: json['uf'],
      );
}
