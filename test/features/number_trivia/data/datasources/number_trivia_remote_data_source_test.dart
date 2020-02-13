import 'dart:convert';

import 'package:flutter_architect/core/error/exception.dart';
import 'package:flutter_architect/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_architect/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

main() {
  NumberTriviaRemoutedataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoutedataSourceImpl(mockHttpClient);
  });

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;

    test(
        'should preform a GET request on a URL with number being the endpoint and with application/json header',
        () {
      setUpMockHttpClientSuccess200(mockHttpClient);

      dataSource.getConcreteNumberTrivia(tNumber);

      verify(mockHttpClient.get(
        'http://numbersapi.com/$tNumber',
        headers: {'Content-Type': 'application/json'},
      ));
    });

    final tnumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixtures("trivia.json")));

    test('should return NumberTrivia when the response code is 200 (success)',
        () async {
      setUpMockHttpClientSuccess200(mockHttpClient);

      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      expect(result, equals(tnumberTriviaModel));
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404(mockHttpClient);
        // act
        final call = dataSource.getConcreteNumberTrivia;
        // assert
        expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}

void setUpMockHttpClientFailure404(MockHttpClient mockHttpClient) {
  when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
    (_) async => http.Response('Something went wrong', 404),
  );
}

void setUpMockHttpClientSuccess200(MockHttpClient mockHttpClient) {
  when(mockHttpClient.get(any, headers: anyNamed("headers")))
      .thenAnswer((_) async => http.Response(fixtures("trivia.json"), 200));
}
