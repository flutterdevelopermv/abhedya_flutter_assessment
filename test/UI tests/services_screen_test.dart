import 'dart:developer';
import 'package:abhedya_flutter_assessment/ui/screens/e_services/services_screen.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('Services Screen UI testing', (tester) async {
    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(MaterialApp(
      home: const ServicesScreen(),
      // routerConfig: GoRouter(
      //     initialLocation: Routes.initialRoute, routes: Routes.routesTree),
      navigatorObservers: [mockObserver],
    ));

    expect(find.byType(ListTile), findsNWidgets(3));
    log("No of Widgets = 3 : true");

    //
    await tester.tap(find.byKey(const Key("Statements")));
    // await tester.pump();
    // await Future.delayed(const Duration(milliseconds: 1));

    expect(find.byType(ServicesScreen), findsNothing);

    /// Verify that a push event happened
  });
}
