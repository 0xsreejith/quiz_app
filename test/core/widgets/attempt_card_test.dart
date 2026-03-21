import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/widgets/attempt_card.dart';

AttemptCard _defaultCard({bool hasLeftBorder = false}) {
  return AttemptCard(
    icon: Icons.school,
    iconColor: Colors.blue,
    iconBgColor: Colors.blue.shade50,
    level: 'MEDIUM',
    levelColor: Colors.orange,
    levelBgColor: Colors.orange.shade50,
    date: 'Jan 01, 2025',
    title: 'General Knowledge Quiz',
    subtitle: '10 Questions',
    score: '8/10',
    status: 'PASSED',
    statusColor: Colors.green,
    statusIcon: Icons.check_circle,
    actionText: 'RETRY',
    actionColor: Colors.blue,
    hasLeftBorder: hasLeftBorder,
  );
}

void main() {
  Widget buildTestWidget(AttemptCard card) {
    return MaterialApp(
      home: Scaffold(body: SingleChildScrollView(child: card)),
    );
  }

  group('AttemptCard - Content rendering', () {
    testWidgets('renders the level badge text', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(_defaultCard()));
      expect(find.text('MEDIUM'), findsOneWidget);
    });

    testWidgets('renders the date', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(_defaultCard()));
      expect(find.text('Jan 01, 2025'), findsOneWidget);
    });

    testWidgets('renders the title', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(_defaultCard()));
      expect(find.text('General Knowledge Quiz'), findsOneWidget);
    });

    testWidgets('renders the subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(_defaultCard()));
      expect(find.text('10 Questions'), findsOneWidget);
    });

    testWidgets('renders the SCORE label', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(_defaultCard()));
      expect(find.text('SCORE'), findsOneWidget);
    });

    testWidgets('renders the score value', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(_defaultCard()));
      expect(find.text('8/10'), findsOneWidget);
    });

    testWidgets('renders the status text', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(_defaultCard()));
      expect(find.text('PASSED'), findsOneWidget);
    });

    testWidgets('renders the action text', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(_defaultCard()));
      expect(find.text('RETRY'), findsOneWidget);
    });
  });

  group('AttemptCard - Icons', () {
    testWidgets('renders the main icon', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(_defaultCard()));
      expect(find.byIcon(Icons.school), findsOneWidget);
    });

    testWidgets('renders the status icon', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(_defaultCard()));
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });
  });

  group('AttemptCard - Left border', () {
    testWidgets('does not show left border container by default', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(_defaultCard()));

      // When hasLeftBorder=false, there's no darkNavy-colored border Container
      final containers = tester.widgetList<Container>(find.byType(Container));
      final borderContainers = containers.where((c) {
        final decoration = c.decoration;
        if (decoration is BoxDecoration) return false;
        // The left border container has a direct color (not BoxDecoration)
        return c.color == AppColors.darkNavy;
      });
      expect(borderContainers, isEmpty);
    });

    testWidgets('shows left border container when hasLeftBorder=true', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(_defaultCard(hasLeftBorder: true)));

      final containers = tester.widgetList<Container>(find.byType(Container));
      final borderContainers = containers.where(
        (c) => c.color == AppColors.darkNavy,
      );
      expect(borderContainers.isNotEmpty, isTrue);
    });

    testWidgets('left border container has width 4', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(_defaultCard(hasLeftBorder: true)));

      final containers = tester.widgetList<Container>(find.byType(Container));
      final borderContainer = containers.firstWhere(
        (c) => c.color == AppColors.darkNavy,
      );
      expect(borderContainer.constraints?.maxWidth, 4.0);
    });
  });

  group('AttemptCard - Different data', () {
    testWidgets('renders correctly with FAILED status', (WidgetTester tester) async {
      const card = AttemptCard(
        icon: Icons.quiz,
        iconColor: Colors.red,
        iconBgColor: Colors.white,
        level: 'HARD',
        levelColor: Colors.red,
        levelBgColor: Colors.white,
        date: 'Feb 14, 2025',
        title: 'Science Quiz',
        subtitle: '5 Questions',
        score: '3/5',
        status: 'FAILED',
        statusColor: Colors.red,
        statusIcon: Icons.cancel,
        actionText: 'TRY AGAIN',
        actionColor: Colors.orange,
        hasLeftBorder: false,
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SingleChildScrollView(child: card)),
        ),
      );

      expect(find.text('HARD'), findsOneWidget);
      expect(find.text('Feb 14, 2025'), findsOneWidget);
      expect(find.text('Science Quiz'), findsOneWidget);
      expect(find.text('3/5'), findsOneWidget);
      expect(find.text('FAILED'), findsOneWidget);
      expect(find.text('TRY AGAIN'), findsOneWidget);
      expect(find.byIcon(Icons.cancel), findsOneWidget);
    });

    testWidgets('renders correctly for EASY level with perfect score', (WidgetTester tester) async {
      const card = AttemptCard(
        icon: Icons.lightbulb,
        iconColor: Colors.amber,
        iconBgColor: Colors.white,
        level: 'EASY',
        levelColor: Colors.green,
        levelBgColor: Colors.white,
        date: 'Mar 01, 2025',
        title: 'Geography Quiz',
        subtitle: '20 Questions',
        score: '20/20',
        status: 'PERFECT',
        statusColor: Colors.green,
        statusIcon: Icons.star,
        actionText: 'PLAY AGAIN',
        actionColor: Colors.green,
        hasLeftBorder: true,
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SingleChildScrollView(child: card)),
        ),
      );

      expect(find.text('EASY'), findsOneWidget);
      expect(find.text('20/20'), findsOneWidget);
      expect(find.text('PERFECT'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });

  group('AttemptCard - Structure', () {
    testWidgets('renders a Container as root', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(_defaultCard()));
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('contains an IntrinsicHeight widget', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(_defaultCard()));
      expect(find.byType(IntrinsicHeight), findsOneWidget);
    });

    testWidgets('contains an Expanded widget for content', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(_defaultCard()));
      expect(find.byType(Expanded), findsWidgets);
    });
  });
}