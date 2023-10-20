import 'package:abhedya_flutter_assessment/data/models/profile.dart';
import 'package:abhedya_flutter_assessment/ui/screens/c_home/bloc/home_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;

    setUp(() {
      homeBloc = HomeBloc();
    });

    test('Initial state is HomeBloc', () {
      expect(homeBloc.state, HomeProfileInitial());
    });

    //
    var sucessProfile = {
      "home": {
        "name": "John Doe",
        "accountNumber": "1234567890",
        "balance": 2500.5,
        "currency": "USD"
      }
    };

    var errorProfile = {
      "home": {
        "name": "John Doe",
        "accountNumber": "1234567890",
        "balance": "2500.5", // Balance should be numeric
        "currency": "USD"
      }
    };

    blocTest(
      "Testing HomeProfile States",
      build: () => homeBloc,
      act: (bloc) {
        bloc.add(HomeProfileEvent(sucessProfile));
        bloc.add(HomeProfileEvent(errorProfile));
      },
      expect: () {
        return [
          HomeProfileSuccess(Profile.fromMap(sucessProfile["home"]!)),
          HomeProfileError(errorProfile)
        ];
      },
    );
  });
}
