// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dictionary/app/data/models/user_model.dart';
import 'package:dictionary/app/data/models/word_model.dart';

class WordHistoryModel {
  int? id;
  int? idUser;
  int? idWord;
  DateTime? lastAcess;
  bool favorite;

  /// Not Map
  UserModel? user;
  WordModel? word;

  WordHistoryModel({
    this.id,
    this.idUser,
    this.idWord,
    this.lastAcess,
    this.favorite = false,
    this.user,
    this.word,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idUser': idUser,
      'idWord': idWord,
      'lastAcess': lastAcess.toString(),
      'favorite': favorite,
      'user': user?.toMap(),
      'word': word?.toMap(),
    };
  }

  static WordHistoryModel fromMap(Map<String, dynamic> map) {
    return WordHistoryModel(
      id: map['id'],
      idUser: map['idUser'],
      idWord: map['idWord'],
      
      lastAcess: map['lastAcess'] == null ? DateTime.now() : DateTime.parse(map['lastAcess'] as String),
      favorite: map['favorite'] ?? false,

      user: map['user'] != null ? UserModel.fromMap(map['user'] as Map<String,dynamic>) : null,
      word: map['word'] != null ? WordModel.fromMap(map['word'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WordHistoryModel.fromJson(String source) => WordHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WordHistoryModel(id: $id, idUser: $idUser, idWord: $idWord, lastAcess: $lastAcess, favorite: $favorite, user: $user, word: $word)';
  }
}
