import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/widgets/bottom_nav_bar.dart';

Widget _buildNavBar({
  int currentIndex = 0,
  ValueChanged<int>? onTap,
}) {
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
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(_buildNavBar());
      expect(find.byType(BottomNavBar), findsOneWidget);
    });

    testWidgets('renders a BottomNavigationBar', (tester) async {
      await tester.pumpWidget(_buildNavBar());
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('renders five navigation items', (tester) async {
      await tester.pumpWidget(_buildNavBar());
      expect(find.byType(BottomNavigationBarItem), findsNWidgets(5));
    });

    testWidgets('renders Home label', (tester) async {
      await tester.pumpWidget(_buildNavBar());
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('renders Live label', (tester) async {
      await tester.pumpWidget(_buildNavBar());
      expect(find.text('Live'), findsOneWidget);
    });

    testWidgets('renders Rank label', (tester) async {
      await tester.pumpWidget(_buildNavBar());
      expect(find.text('Rank'), findsOneWidget);
    });

    testWidgets('renders History label', (tester) async {
      await tester.pumpWidget(_buildNavBar());
      expect(find.text('History'), findsOneWidget);
    });

    testWidgets('renders Profile label', (tester) async {
      await tester.pumpWidget(_buildNavBar());
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('renders Home icon', (tester) async {
      await tester.pumpWidget(_buildNavBar());
      expect(find.byIcon(Icons.home_outlined), findsWidgets);
    });

    testWidgets('renders History icon', (tester) async {
      await tester.pumpWidget(_buildNavBar());
      expect(find.byIcon(Icons.history_outlined), findsWidgets);
    });

    testWidgets('renders Profile icon', (tester) async {
      await tester.pumpWidget(_buildNavBar());
      expect(find.byIcon(Icons.person_outline), findsWidgets);
    });
  });

  group('BottomNavBar — currentIndex', () {
    testWidgets('currentIndex 0 sets Home as active', (tester) async {
      await tester.pumpWidget(_buildNavBar(currentIndex: 0));
      final navBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(navBar.currentIndex, equals(0));
    });

    testWidgets('currentIndex 1 sets Live as active', (tester) async {
      await tester.pumpWidget(_buildNavBar(currentIndex: 1));
      final navBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(navBar.currentIndex, equals(1));
    });

    testWidgets('currentIndex 2 sets Rank as active', (tester) async {
      await tester.pumpWidget(_buildNavBar(currentIndex: 2));
      final navBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(navBar.currentIndex, equals(2));
    });

    testWidgets('currentIndex 3 sets History as active', (tester) async {
      await tester.pumpWidget(_buildNavBar(currentIndex: 3));
      final navBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(navBar.currentIndex, equals(3));
    });

    testWidgets('currentIndex 4 sets Profile as active', (tester) async {
      await tester.pumpWidget(_buildNavBar(currentIndex: 4));
      final navBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(navBar.currentIndex, equals(4));
    });
  });

  group('BottomNavBar — onTap callback', () {
    testWidgets('calls onTap with correct index when History is tapped', (tester) async {
      int? tappedIndex;
      await tester.pumpWidget(_buildNavBar(
        currentIndex: 0,
        onTap: (index) => tappedIndex = index,
      ));

      await tester.tap(find.text('History'));
      await tester.pump();

      expect(tappedIndex, equals(3));
    });

    testWidgets('calls onTap with correct index when Profile is tapped', (tester) async {
      int? tappedIndex;
      await tester.pumpWidget(_buildNavBar(
        currentIndex: 0,
        onTap: (index) => tappedIndex = index,
      ));

      await tester.tap(find.text('Profile'));
      await tester.pump();

      expect(tappedIndex, equals(4));
    });

    testWidgets('calls onTap with index 0 when Home is tapped from different tab', (tester) async {
      int? tappedIndex;
      await tester.pumpWidget(_buildNavBar(
        currentIndex: 4,
        onTap: (index) => tappedIndex = index,
      ));

      await tester.tap(find.text('Home'));
      await tester.pump();

      expect(tappedIndex, equals(0));
    });

    testWidgets('calls onTap with index 1 when Live is tapped', (tester) async {
      int? tappedIndex;
      await tester.pumpWidget(_buildNavBar(
        currentIndex: 0,
        onTap: (index) => tappedIndex = index,
      ));

      await tester.tap(find.text('Live'));
      await tester.pump();

      expect(tappedIndex, equals(1));
    });
  });

  group('BottomNavBar — type', () {
    testWidgets('uses fixed type so all items remain visible', (tester) async {
      await tester.pumpWidget(_buildNavBar());
      final navBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(navBar.type, equals(BottomNavigationBarType.fixed));
    });
  });
}