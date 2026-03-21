import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/widgets/footer_section.dart';

Widget _buildFooter({
  String title = 'END OF TRANSMISSION',
  String subtitle = 'No more results to show.',
}) {
  return MaterialApp(
    home: Scaffold(
      body: FooterSection(
        title: title,
        subtitle: subtitle,
      ),
    ),
  );
}

void main() {
  group('FooterSection — rendering', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(_buildFooter());
      expect(find.byType(FooterSection), findsOneWidget);
    });

    testWidgets('displays the title text', (tester) async {
      await tester.pumpWidget(_buildFooter(title: 'END OF TRANSMISSION'));
      expect(find.text('END OF TRANSMISSION'), findsOneWidget);
    });

    testWidgets('displays the subtitle text', (tester) async {
      await tester.pumpWidget(_buildFooter(subtitle: 'All caught up!'));
      expect(find.text('All caught up!'), findsOneWidget);
    });

    testWidgets('displays different title text correctly', (tester) async {
      await tester.pumpWidget(_buildFooter(title: 'NO MORE RECORDS'));
      expect(find.text('NO MORE RECORDS'), findsOneWidget);
    });

    testWidgets('displays different subtitle text correctly', (tester) async {
      await tester.pumpWidget(_buildFooter(
        subtitle: 'You have completed all available quiz attempts.',
      ));
      expect(
        find.text('You have completed all available quiz attempts.'),
        findsOneWidget,
      );
    });
  });

  group('FooterSection — layout', () {
    testWidgets('contains a Column at the root', (tester) async {
      await tester.pumpWidget(_buildFooter());
      expect(find.descendant(of: find.byType(FooterSection), matching: find.byType(Column)), findsWidgets);
    });

    testWidgets('renders a divider line Container', (tester) async {
      await tester.pumpWidget(_buildFooter());
      // The divider is a Container with height=1 inside a Row
      final containers = tester.widgetList<Container>(find.byType(Container)).toList();
      final dividerContainers = containers.where((c) {
        return c.color != null;
      }).toList();
      expect(dividerContainers, isNotEmpty);
    });

    testWidgets('renders two Text widgets (title and subtitle)', (tester) async {
      await tester.pumpWidget(_buildFooter(
        title: 'TITLE_TEXT',
        subtitle: 'SUBTITLE_TEXT',
      ));
      expect(find.text('TITLE_TEXT'), findsOneWidget);
      expect(find.text('SUBTITLE_TEXT'), findsOneWidget);
    });
  });

  group('FooterSection — text alignment', () {
    testWidgets('title text has center alignment', (tester) async {
      await tester.pumpWidget(_buildFooter(title: 'MY TITLE'));
      final titleWidget = tester.widget<Text>(find.text('MY TITLE'));
      expect(titleWidget.textAlign, equals(TextAlign.center));
    });

    testWidgets('subtitle text has center alignment', (tester) async {
      await tester.pumpWidget(_buildFooter(subtitle: 'my subtitle'));
      final subtitleWidget = tester.widget<Text>(find.text('my subtitle'));
      expect(subtitleWidget.textAlign, equals(TextAlign.center));
    });
  });

  group('FooterSection — edge cases', () {
    testWidgets('handles empty title string', (tester) async {
      await tester.pumpWidget(_buildFooter(title: '', subtitle: 'Some subtitle'));
      expect(find.byType(FooterSection), findsOneWidget);
    });

    testWidgets('handles empty subtitle string', (tester) async {
      await tester.pumpWidget(_buildFooter(title: 'Some title', subtitle: ''));
      expect(find.byType(FooterSection), findsOneWidget);
    });

    testWidgets('handles long title without overflow error', (tester) async {
      await tester.pumpWidget(_buildFooter(
        title: 'THIS IS A VERY LONG SECTION TITLE THAT MIGHT OVERFLOW',
      ));
      expect(find.byType(FooterSection), findsOneWidget);
    });

    testWidgets('handles long subtitle without overflow error', (tester) async {
      await tester.pumpWidget(_buildFooter(
        subtitle: 'This is a much longer subtitle text that spans multiple lines '
            'and should wrap gracefully within the available width.',
      ));
      expect(find.byType(FooterSection), findsOneWidget);
    });
  });
}