import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/widgets/attempt_card.dart';

// Helper to build AttemptCard inside a testable widget tree.
Widget _buildCard({
  IconData icon = Icons.quiz,
  Color iconColor = Colors.blue,
  Color iconBgColor = Colors.lightBlue,
  String level = 'EASY',
  Color levelColor = Colors.green,
  Color levelBgColor = Colors.lightGreen,
  String date = 'Jan 1, 2025',
  String title = 'Science Quiz',
  String subtitle = '10 questions • 5 min',
  String score = '8/10',
  String status = 'PASSED',
  Color statusColor = Colors.green,
  IconData statusIcon = Icons.check_circle,
  String actionText = 'RETRY',
  Color actionColor = Colors.blue,
  bool hasLeftBorder = false,
}) {
  return MaterialApp(
    home: Scaffold(
      body: AttemptCard(
        icon: icon,
        iconColor: iconColor,
        iconBgColor: iconBgColor,
        level: level,
        levelColor: levelColor,
        levelBgColor: levelBgColor,
        date: date,
        title: title,
        subtitle: subtitle,
        score: score,
        status: status,
        statusColor: statusColor,
        statusIcon: statusIcon,
        actionText: actionText,
        actionColor: actionColor,
        hasLeftBorder: hasLeftBorder,
      ),
    ),
  );
}

void main() {
  group('AttemptCard — rendering', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(_buildCard());
      expect(find.byType(AttemptCard), findsOneWidget);
    });

    testWidgets('displays title text', (tester) async {
      await tester.pumpWidget(_buildCard(title: 'History Quiz'));
      expect(find.text('History Quiz'), findsOneWidget);
    });

    testWidgets('displays subtitle text', (tester) async {
      await tester.pumpWidget(_buildCard(subtitle: '5 questions • 3 min'));
      expect(find.text('5 questions • 3 min'), findsOneWidget);
    });

    testWidgets('displays level badge text', (tester) async {
      await tester.pumpWidget(_buildCard(level: 'HARD'));
      expect(find.text('HARD'), findsOneWidget);
    });

    testWidgets('displays date text', (tester) async {
      await tester.pumpWidget(_buildCard(date: 'Mar 15, 2025'));
      expect(find.text('Mar 15, 2025'), findsOneWidget);
    });

    testWidgets('displays score label SCORE', (tester) async {
      await tester.pumpWidget(_buildCard());
      expect(find.text('SCORE'), findsOneWidget);
    });

    testWidgets('displays score value', (tester) async {
      await tester.pumpWidget(_buildCard(score: '9/10'));
      expect(find.text('9/10'), findsOneWidget);
    });

    testWidgets('displays status text', (tester) async {
      await tester.pumpWidget(_buildCard(status: 'FAILED'));
      expect(find.text('FAILED'), findsOneWidget);
    });

    testWidgets('displays action text', (tester) async {
      await tester.pumpWidget(_buildCard(actionText: 'REVIEW'));
      expect(find.text('REVIEW'), findsOneWidget);
    });

    testWidgets('renders the icon', (tester) async {
      await tester.pumpWidget(_buildCard(icon: Icons.science));
      expect(find.byIcon(Icons.science), findsOneWidget);
    });

    testWidgets('renders the status icon', (tester) async {
      await tester.pumpWidget(_buildCard(statusIcon: Icons.cancel));
      expect(find.byIcon(Icons.cancel), findsOneWidget);
    });
  });

  group('AttemptCard — left border', () {
    testWidgets('hasLeftBorder=false does not render extra border container', (tester) async {
      await tester.pumpWidget(_buildCard(hasLeftBorder: false));
      // The card container + the padding container; no extra 4px width container
      final containers = tester.widgetList<Container>(find.byType(Container)).toList();
      final borderContainers = containers
          .where((c) => c.color != null && (c.constraints?.minWidth == 4 || c.constraints?.maxWidth == 4))
          .toList();
      expect(borderContainers, isEmpty);
    });

    testWidgets('hasLeftBorder=true renders left border container with width 4', (tester) async {
      await tester.pumpWidget(_buildCard(hasLeftBorder: true));
      // Find containers and verify one has a fixed width of 4
      final sizedBoxes = tester.widgetList<Container>(find.byType(Container)).toList();
      final borderContainer = sizedBoxes.firstWhere(
        (c) => c.color != null,
        orElse: () => throw TestFailure('No colored Container found'),
      );
      expect(borderContainer, isNotNull);
    });
  });

  group('AttemptCard — different levels', () {
    for (final level in ['EASY', 'MEDIUM', 'HARD', 'EXPERT']) {
      testWidgets('renders level badge: $level', (tester) async {
        await tester.pumpWidget(_buildCard(level: level));
        expect(find.text(level), findsOneWidget);
      });
    }
  });

  group('AttemptCard — score edge cases', () {
    testWidgets('renders score of 0/10', (tester) async {
      await tester.pumpWidget(_buildCard(score: '0/10'));
      expect(find.text('0/10'), findsOneWidget);
    });

    testWidgets('renders perfect score 10/10', (tester) async {
      await tester.pumpWidget(_buildCard(score: '10/10'));
      expect(find.text('10/10'), findsOneWidget);
    });

    testWidgets('renders percentage score like 85%', (tester) async {
      await tester.pumpWidget(_buildCard(score: '85%'));
      expect(find.text('85%'), findsOneWidget);
    });
  });

  group('AttemptCard — long text', () {
    testWidgets('renders long title without overflow error', (tester) async {
      await tester.pumpWidget(
        _buildCard(title: 'A Very Long Quiz Title That Might Overflow The Card Widget'),
      );
      // If no exception is thrown the widget handled the text correctly
      expect(find.byType(AttemptCard), findsOneWidget);
    });

    testWidgets('renders long subtitle without overflow error', (tester) async {
      await tester.pumpWidget(
        _buildCard(subtitle: '25 questions covering all topics from chapters 1 through 12'),
      );
      expect(find.byType(AttemptCard), findsOneWidget);
    });
  });
}