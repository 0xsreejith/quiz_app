import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/widgets/bottom_nav_bar.dart';

Widget _buildSubject({required int currentIndex, ValueChanged<int>? onTap}) {
  return MaterialApp(
    home: Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: onTap ?? (_) {},
      ),
    ),
  );
}

void main() {
  group('BottomNavBar — rendering', () {
    testWidgets('renders five navigation items', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(currentIndex: 0));

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Live'), findsOneWidget);
      expect(find.text('Rank'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('uses BottomNavigationBarType.fixed', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(currentIndex: 0));

      final navBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(navBar.type, equals(BottomNavigationBarType.fixed));
    });

    testWidgets('currentIndex reflects the passed value', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(currentIndex: 3));

      final navBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(navBar.currentIndex, equals(3));
    });
  });

  group('BottomNavBar — tap callbacks', () {
    testWidgets('onTap is called with correct index when Home is tapped',
        (WidgetTester tester) async {
      int? tappedIndex;
      await tester.pumpWidget(
        _buildSubject(currentIndex: 2, onTap: (i) => tappedIndex = i),
      );

      await tester.tap(find.text('Home'));
      await tester.pump();

      expect(tappedIndex, equals(0));
    });

    testWidgets('onTap is called with correct index when Profile is tapped',
        (WidgetTester tester) async {
      int? tappedIndex;
      await tester.pumpWidget(
        _buildSubject(currentIndex: 0, onTap: (i) => tappedIndex = i),
      );

      await tester.tap(find.text('Profile'));
      await tester.pump();

      expect(tappedIndex, equals(4));
    });

    testWidgets('onTap is called with correct index when History is tapped',
        (WidgetTester tester) async {
      int? tappedIndex;
      await tester.pumpWidget(
        _buildSubject(currentIndex: 0, onTap: (i) => tappedIndex = i),
      );

      await tester.tap(find.text('History'));
      await tester.pump();

      expect(tappedIndex, equals(3));
    });
  });

  group('BottomNavBar — icons', () {
    testWidgets('renders home_outlined icon', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(currentIndex: 0));
      expect(find.byIcon(Icons.home_outlined), findsWidgets);
    });

    testWidgets('renders person_outline icon', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(currentIndex: 0));
      expect(find.byIcon(Icons.person_outline), findsWidgets);
    });

    testWidgets('renders history_outlined icon', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(currentIndex: 0));
      expect(find.byIcon(Icons.history_outlined), findsWidgets);
    });
  });

  group('BottomNavBar — edge cases', () {
    testWidgets('currentIndex 0 (first tab) renders without error',
        (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(currentIndex: 0));
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('currentIndex 4 (last tab) renders without error',
        (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(currentIndex: 4));
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });
  });
}