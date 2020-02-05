import 'dart:convert';

import 'package:flutter_architect/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_architect/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: "Test Text");

  test('should be a subclass of NumberTrivia entity', () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group("fromJson", () {
    test(
        'should return a valid model when the JSON number is regarded as a integer',
        () async {
      final Map<String, dynamic> jsonMap = json.decode(fixtures("trivia.json"));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, isA<NumberTrivia>());
    });
    test(
        'should return a valid model when the JSON number is regarded as a double',
        () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixtures("trivia_double.json"));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, isA<NumberTrivia>());
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      final result = tNumberTriviaModel.toJson();
      final expectedJsonMap = {
        "text": "Test Text",
        "number": 1,
      };
      expect(expectedJsonMap, result);
    });
  });
}
