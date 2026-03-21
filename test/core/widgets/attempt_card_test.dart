import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/widgets/attempt_card.dart';

/// Helper to build a default AttemptCard inside a testable widget tree.
Widget _buildCard({
  IconData icon = Icons.science,
  Color iconColor = Colors.blue,
  Color iconBgColor = const Color(0xFFE0E7FF),
  String level = 'EASY',
  Color levelColor = Colors.green,
  Color levelBgColor = const Color(0xFFD1FAE5),
  String date = '12 Jan 2024',
  String title = 'General Knowledge',
  String subtitle = '20 questions · 10 mins',
  String score = '18/20',
  String status = 'PASSED',
  Color statusColor = Colors.green,
  IconData statusIcon = Icons.check_circle,
  String actionText = 'REVIEW',
  Color actionColor = Colors.blue,
  bool hasLeftBorder = false,
}) {
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: AttemptCard(
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
    ),
  );
}

void main() {
  group('AttemptCard — text content', () {
    testWidgets('displays the title', (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard(title: 'World History'));
      expect(find.text('World History'), findsOneWidget);
    });

    testWidgets('displays the subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard(subtitle: '15 questions · 5 mins'));
      expect(find.text('15 questions · 5 mins'), findsOneWidget);
    });

    testWidgets('displays the score', (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard(score: '9/10'));
      expect(find.text('9/10'), findsOneWidget);
    });

    testWidgets('displays the level badge text', (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard(level: 'HARD'));
      expect(find.text('HARD'), findsOneWidget);
    });

    testWidgets('displays the date', (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard(date: '01 Mar 2025'));
      expect(find.text('01 Mar 2025'), findsOneWidget);
    });

    testWidgets('displays the status text', (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard(status: 'FAILED'));
      expect(find.text('FAILED'), findsOneWidget);
    });

    testWidgets('displays the SCORE label', (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard());
      expect(find.text('SCORE'), findsOneWidget);
    });

    testWidgets('displays the actionText', (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard(actionText: 'RETRY'));
      expect(find.text('RETRY'), findsOneWidget);
    });
  });

  group('AttemptCard — left border', () {
    testWidgets('shows left border container when hasLeftBorder is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard(hasLeftBorder: true));

      // Find containers with width=4 and the darkNavy color
      final containers = tester
          .widgetList<Container>(find.byType(Container))
          .toList();

      final borderContainer = containers.firstWhere(
        (c) {
          final decoration = c.decoration;
          if (decoration is BoxDecoration) {
            return decoration.color == AppColors.darkNavy;
          }
          return c.color == AppColors.darkNavy;
        },
        orElse: () => throw TestFailure('Could not find left border container'),
      );
      expect(borderContainer, isNotNull);
    });

    testWidgets('does not show left border when hasLeftBorder is false (default)',
        (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard(hasLeftBorder: false));

      // No container with darkNavy color and width=4 should exist
      final containers = tester
          .widgetList<Container>(find.byType(Container))
          .toList();

      final hasBorderContainer = containers.any((c) {
        final decoration = c.decoration;
        if (decoration is BoxDecoration) {
          return decoration.color == AppColors.darkNavy;
        }
        return c.color == AppColors.darkNavy;
      });

      expect(hasBorderContainer, isFalse);
    });

    testWidgets('hasLeftBorder defaults to false', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AttemptCard(
                icon: Icons.book,
                iconColor: Colors.blue,
                iconBgColor: Colors.blue.shade100,
                level: 'MEDIUM',
                levelColor: Colors.orange,
                levelBgColor: Colors.orange.shade100,
                date: '01 Jan 2024',
                title: 'Test Quiz',
                subtitle: '5 questions',
                score: '4/5',
                status: 'PASSED',
                statusColor: Colors.green,
                statusIcon: Icons.check,
                actionText: 'REVIEW',
                actionColor: Colors.blue,
                // hasLeftBorder not provided — should default to false
              ),
            ),
          ),
        ),
      );

      final containers = tester
          .widgetList<Container>(find.byType(Container))
          .toList();

      final hasBorderContainer = containers.any((c) {
        final decoration = c.decoration;
        if (decoration is BoxDecoration) {
          return decoration.color == AppColors.darkNavy;
        }
        return c.color == AppColors.darkNavy;
      });

      expect(hasBorderContainer, isFalse);
    });
  });

  group('AttemptCard — icon rendering', () {
    testWidgets('renders the provided icon', (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard(icon: Icons.science));
      expect(find.byIcon(Icons.science), findsOneWidget);
    });

    testWidgets('renders the provided statusIcon', (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard(statusIcon: Icons.cancel));
      expect(find.byIcon(Icons.cancel), findsOneWidget);
    });
  });

  group('AttemptCard — layout structure', () {
    testWidgets('renders an IntrinsicHeight widget', (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard());
      expect(find.byType(IntrinsicHeight), findsOneWidget);
    });

    testWidgets('renders without overflow for typical data', (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard(
        title: 'A' * 60,
        subtitle: 'B' * 40,
        score: '100/100',
        level: 'MEDIUM',
      ));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders correctly with short strings', (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard(
        title: 'Q',
        subtitle: 'S',
        score: '0',
        level: 'E',
      ));
      expect(find.text('Q'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });
  });

  group('AttemptCard — different level and status variants', () {
    testWidgets('renders HARD level correctly', (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard(level: 'HARD', levelColor: Colors.red));
      expect(find.text('HARD'), findsOneWidget);
    });

    testWidgets('renders FAILED status correctly', (WidgetTester tester) async {
      await tester.pumpWidget(_buildCard(
        status: 'FAILED',
        statusColor: Colors.red,
        statusIcon: Icons.cancel,
      ));
      expect(find.text('FAILED'), findsOneWidget);
      expect(find.byIcon(Icons.cancel), findsOneWidget);
    });
  });
}