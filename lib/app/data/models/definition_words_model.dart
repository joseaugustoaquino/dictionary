// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DefinitionWordModel {
  String? word;
  double? frequency;

  SyllablesModel? syllables;
  PronunciationModel? pronunciation;

  List<ResultModel>? results;
  DefinitionWordModel({
    this.word,
    this.frequency,
    this.syllables,
    this.pronunciation,
    this.results,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'word': word,
      'frequency': frequency,

      'syllables': syllables?.toMap(),
      'pronunciation': pronunciation?.toMap(),
      'results': results?.map((x) => x.toMap()).toList(),
    };
  }

  static DefinitionWordModel fromMap(Map<String, dynamic> map) {
    return DefinitionWordModel(
      word: map['word'],
      frequency: map['frequency'],

      syllables: map['syllables'] != null 
        ? SyllablesModel.fromMap(map['syllables'] as Map<String,dynamic>) : null,
      pronunciation: map['pronunciation'] != null 
        ? PronunciationModel.fromMap(map['pronunciation'] as Map<String,dynamic>) : null,
      results: map['results'] != null 
        ? List<ResultModel>.from((map['results'] as List<dynamic>).map<ResultModel?>((x) => ResultModel.fromMap(x as Map<String,dynamic>))) : null,
    );
  }

  String toJson() => json.encode(toMap());
}

class SyllablesModel {
  int? count;
  List<String>? list;

  SyllablesModel({
    this.count,
    this.list,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'list': list,
    };
  }

  static SyllablesModel fromMap(Map<String, dynamic> map) {
    return SyllablesModel(
      count: map['count'],
      list: map['list'] != null
        ? List<String>.from((map['list'] as List<dynamic>)) : null,
    );
  }

  String toJson() => json.encode(toMap());
}

class PronunciationModel {
  String? all;

  PronunciationModel({
    this.all,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'all': all,
    };
  }

  static PronunciationModel fromMap(Map<String, dynamic> map) {
    return PronunciationModel(
      all: map['all'],
    );
  }

  String toJson() => json.encode(toMap());
}

class ResultModel {
  String? definition;
  String? partOfSpeech;
  List<String?>? typeOf;
  List<String?>? hasTypes;
  List<String?>? derivation;

  ResultModel({
    this.definition,
    this.partOfSpeech,
    this.typeOf,
    this.hasTypes,
    this.derivation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'definition': definition,
      'partOfSpeech': partOfSpeech,
      'typeOf': typeOf?.map((x) => x).toList(),
      'hasTypes': hasTypes?.map((x) => x).toList(),
      'derivation': derivation?.map((x) => x).toList(),
    };
  }

  static ResultModel fromMap(Map<String, dynamic> map) {
    return ResultModel(
      definition: map['definition'],
      partOfSpeech: map['partOfSpeech'],

      typeOf: map['typeOf'] != null 
        ? List<String>.from((map['typeOf'] as List<dynamic>)) : null,
      
      hasTypes: map['hasTypes'] != null 
        ? List<String>.from((map['hasTypes'] as List<dynamic>)) : null,
      
      derivation: map['derivation'] != null 
        ? List<String>.from((map['derivation'] as List<dynamic>)) : null,
    );
  }

  String toJson() => json.encode(toMap());
}
