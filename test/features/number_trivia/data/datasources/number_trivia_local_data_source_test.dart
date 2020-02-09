import 'package:flutter_architect/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferens extends Mock implements SharedPreferences {}

main() {
  MockSharedPreferens mockSharedPreferens;
  NumberTriviaLocalDataSourceImpl localDataSource;

  setUp(() {
    mockSharedPreferens = MockSharedPreferens();
    localDataSource = NumberTriviaLocalDataSourceImpl(sharedPreferences: mockSharedPreferens,);
  });

  group('localDataSource', () {
    test('sould save and get number trivia from shared preferences', () {
      
    });
  })
}