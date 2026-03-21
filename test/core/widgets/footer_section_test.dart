import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/widgets/footer_section.dart';

Widget _buildSubject({required String title, required String subtitle}) {
  return MaterialApp(
    home: Scaffold(
      body: FooterSection(title: title, subtitle: subtitle),
    ),
  );
}

void main() {
  group('FooterSection — rendering', () {
    testWidgets('displays the provided title', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(
        title: 'END OF TRANSMISSION',
        subtitle: 'No more records.',
      ));
      expect(find.text('END OF TRANSMISSION'), findsOneWidget);
    });

    testWidgets('displays the provided subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(
        title: 'DONE',
        subtitle: 'You have reached the end of your quiz history.',
      ));
      expect(
        find.text('You have reached the end of your quiz history.'),
        findsOneWidget,
      );
    });

    testWidgets('renders without error for empty title and subtitle',
        (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(title: '', subtitle: ''));
      expect(find.byType(FooterSection), findsOneWidget);
    });

    testWidgets('renders at least one Container (for the divider line)',
        (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(
        title: 'TITLE',
        subtitle: 'subtitle',
      ));
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('title text has center alignment', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(
        title: 'CENTERED TITLE',
        subtitle: 'sub',
      ));
      final titleText = tester.widget<Text>(find.text('CENTERED TITLE'));
      expect(titleText.textAlign, equals(TextAlign.center));
    });

    testWidgets('subtitle text has center alignment', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(
        title: 'T',
        subtitle: 'Centered subtitle',
      ));
      final subtitleText = tester.widget<Text>(find.text('Centered subtitle'));
      expect(subtitleText.textAlign, equals(TextAlign.center));
    });

    testWidgets('root widget is a Column', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(title: 'T', subtitle: 'S'));
      // FooterSection.build returns a Column
      expect(
        find.descendant(of: find.byType(FooterSection), matching: find.byType(Column)),
        findsWidgets,
      );
    });

    testWidgets('long text does not cause overflow error', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(
        title: 'A' * 80,
        subtitle: 'B' * 200,
      ));
      // No overflow assertions thrown
      expect(tester.takeException(), isNull);
    });
  });
}