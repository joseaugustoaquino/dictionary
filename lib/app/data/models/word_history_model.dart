// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WordHistoryModel {
  int? id;
  int? idUser;
  int? idWord;
  String lastAcess;
  String favorite;

  WordHistoryModel({
    this.id,
    this.idUser,
    this.idWord,

    this.lastAcess = "",
    this.favorite = "",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idUser': idUser,
      'idWord': idWord,

      'lastAcess': lastAcess,
      'favorite': favorite,
    };
  }

  static WordHistoryModel fromMap(Map<String, dynamic> map) {
    return WordHistoryModel(
      id: map['id'],
      idUser: map['idUser'],
      idWord: map['idWord'],
      
      lastAcess: map['lastAcess'] ?? "",
      favorite: map['favorite'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory WordHistoryModel.fromJson(String source) => WordHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WordHistoryModel(id: $id, idUser: $idUser, idWord: $idWord, lastAcess: $lastAcess, favorite: $favorite)';
  }
}
