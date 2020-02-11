import 'dart:convert';

import 'package:flutter_architect/core/error/exception.dart';
import 'package:flutter_architect/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_architect/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferens extends Mock implements SharedPreferences {}

main() {
  MockSharedPreferens mockSharedPreferens;
  NumberTriviaLocalDataSourceImpl localDataSource;
  NumberTriviaModel tNumberTriviaModel;

  setUp(() {
    mockSharedPreferens = MockSharedPreferens();
    localDataSource = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferens,
    );
    tNumberTriviaModel = NumberTriviaModel(text: "Test Text", number: 1);
  });

  group('localDataSource', () {
    test(
        'should return NumberTrivia from SharedPreferences when there is one in the cache',
        () async {
      // arrange
      when(mockSharedPreferens.getString(any))
          .thenReturn(fixtures('trivia_cached.json'));
      // act
      final result = await localDataSource.getLastNumberTrivia();
      // assert
      verify(mockSharedPreferens.getString(CACHED_NUMBER_TRIVIA));
      expect(result, equals(tNumberTriviaModel));
    });
    test('should throw a CacheException when there is not a cached value', () {
      // arrange
      when(mockSharedPreferens.getString(any)).thenReturn(null);
      // act
      // Not calling the method here, just storing it inside a call variable
      final call = localDataSource.getLastNumberTrivia;
      // assert
      // Calling the method happens from a higher-order function passed.
      // This is needed to test if calling a method throws an exception.
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel(number: 1, text: 'test trivia');

    test('should call SharedPreferences to cache the data', () {
      // act
      localDataSource.cacheNumberTrivia(tNumberTriviaModel);
      // assert
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(mockSharedPreferens.setString(
        CACHED_NUMBER_TRIVIA,
        expectedJsonString,
      ));
    });
  });
}
