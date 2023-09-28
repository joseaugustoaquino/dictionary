// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WordModel {
  int? id;
  String description;

  WordModel({
    this.id,
    this.description = "",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
    };
  }

  static WordModel fromMap(Map<String, dynamic> map) {
    return WordModel(
      id: map['id'],
      description: map['description'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory WordModel.fromJson(String source) => WordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WordModel(id: $id, description: $description)';
}
