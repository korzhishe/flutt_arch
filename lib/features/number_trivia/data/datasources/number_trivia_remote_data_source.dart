import 'dart:convert';

import 'package:flutter_architect/core/error/exception.dart';
import 'package:flutter_architect/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoutedataSourceImpl
    implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoutedataSourceImpl(this.client);

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    final respons = await client.get(
      'http://numbersapi.com/$number',
      headers: {'Content-Type': 'application/json'},
    );

    if (respons.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(respons.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
