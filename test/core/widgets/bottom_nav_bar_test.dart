import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/widgets/bottom_nav_bar.dart';

void main() {
  Widget buildTestWidget({
    required int currentIndex,
    required ValueChanged<int> onTap,
  }) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavBar(
          currentIndex: currentIndex,
          onTap: onTap,
        ),
      ),
    );
  }

  group('BottomNavBar - Rendering', () {
    testWidgets('renders five navigation items', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));

      expect(find.byType(BottomNavigationBarItem), findsNWidgets(5));
    });

    testWidgets('shows Home label', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('shows Live label', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));
      expect(find.text('Live'), findsOneWidget);
    });

    testWidgets('shows Rank label', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));
      expect(find.text('Rank'), findsOneWidget);
    });

    testWidgets('shows History label', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));
      expect(find.text('History'), findsOneWidget);
    });

    testWidgets('shows Profile label', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('renders a BottomNavigationBar widget', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });
  });

  group('BottomNavBar - Current index', () {
    testWidgets('reflects currentIndex=0 (Home selected)', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));
      final navBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(navBar.currentIndex, 0);
    });

    testWidgets('reflects currentIndex=2 (Rank selected)', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 2, onTap: (_) {}));
      final navBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(navBar.currentIndex, 2);
    });

    testWidgets('reflects currentIndex=4 (Profile selected)', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 4, onTap: (_) {}));
      final navBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(navBar.currentIndex, 4);
    });
  });

  group('BottomNavBar - Tap callbacks', () {
    testWidgets('calls onTap with correct index when item tapped', (WidgetTester tester) async {
      int? tappedIndex;
      await tester.pumpWidget(
        buildTestWidget(
          currentIndex: 0,
          onTap: (index) => tappedIndex = index,
        ),
      );

      // Tap the Rank item (index 2)
      await tester.tap(find.text('Rank'));
      await tester.pump();

      expect(tappedIndex, 2);
    });

    testWidgets('calls onTap with index 4 when Profile tapped', (WidgetTester tester) async {
      int? tappedIndex;
      await tester.pumpWidget(
        buildTestWidget(
          currentIndex: 0,
          onTap: (index) => tappedIndex = index,
        ),
      );

      await tester.tap(find.text('Profile'));
      await tester.pump();

      expect(tappedIndex, 4);
    });

    testWidgets('calls onTap with index 0 when Home tapped', (WidgetTester tester) async {
      int? tappedIndex;
      await tester.pumpWidget(
        buildTestWidget(
          currentIndex: 2,
          onTap: (index) => tappedIndex = index,
        ),
      );

      await tester.tap(find.text('Home'));
      await tester.pump();

      expect(tappedIndex, 0);
    });
  });

  group('BottomNavBar - Icon presence', () {
    testWidgets('contains home outlined icon', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));
      expect(find.byIcon(Icons.home_outlined), findsOneWidget);
    });

    testWidgets('contains live_tv_outlined icon', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));
      expect(find.byIcon(Icons.live_tv_outlined), findsOneWidget);
    });

    testWidgets('contains emoji_events_outlined icon', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));
      expect(find.byIcon(Icons.emoji_events_outlined), findsOneWidget);
    });

    testWidgets('contains history_outlined icon', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));
      expect(find.byIcon(Icons.history_outlined), findsOneWidget);
    });

    testWidgets('contains person_outline icon', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });
  });
}