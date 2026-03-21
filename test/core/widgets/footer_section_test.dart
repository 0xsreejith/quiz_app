import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/widgets/footer_section.dart';

void main() {
  Widget buildTestWidget({required String title, required String subtitle}) {
    return MaterialApp(
      home: Scaffold(
        body: FooterSection(title: title, subtitle: subtitle),
      ),
    );
  }

  group('FooterSection - Content', () {
    testWidgets('displays the provided title', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          title: 'END OF TRANSMISSION',
          subtitle: 'No more records to show.',
        ),
      );
      expect(find.text('END OF TRANSMISSION'), findsOneWidget);
    });

    testWidgets('displays the provided subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          title: 'END OF TRANSMISSION',
          subtitle: 'No more records to show.',
        ),
      );
      expect(find.text('No more records to show.'), findsOneWidget);
    });

    testWidgets('renders with different title and subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          title: 'DONE',
          subtitle: 'All caught up!',
        ),
      );
      expect(find.text('DONE'), findsOneWidget);
      expect(find.text('All caught up!'), findsOneWidget);
    });
  });

  group('FooterSection - Layout', () {
    testWidgets('renders a Column as root widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(title: 'TITLE', subtitle: 'Subtitle'),
      );
      // FooterSection uses Column internally
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('includes a small horizontal divider container', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(title: 'TITLE', subtitle: 'Subtitle'),
      );
      // The divider is a Container widget inside the layout
      expect(find.byType(Container), findsWidgets);
    });
  });

  group('FooterSection - Text alignment', () {
    testWidgets('title Text widget has center alignment', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(title: 'FOOTER TITLE', subtitle: 'sub'),
      );
      final titleWidget = tester.widget<Text>(find.text('FOOTER TITLE'));
      expect(titleWidget.textAlign, TextAlign.center);
    });

    testWidgets('subtitle Text widget has center alignment', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(title: 'TITLE', subtitle: 'Footer subtitle text'),
      );
      final subtitleWidget = tester.widget<Text>(
        find.text('Footer subtitle text'),
      );
      expect(subtitleWidget.textAlign, TextAlign.center);
    });
  });

  group('FooterSection - Styling', () {
    testWidgets('title has small font size (10)', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(title: 'LABEL', subtitle: 'Detail'),
      );
      final titleWidget = tester.widget<Text>(find.text('LABEL'));
      expect(titleWidget.style?.fontSize, 10.0);
    });

    testWidgets('title has heavy font weight (w700)', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(title: 'LABEL', subtitle: 'Detail'),
      );
      final titleWidget = tester.widget<Text>(find.text('LABEL'));
      expect(titleWidget.style?.fontWeight, FontWeight.w700);
    });

    testWidgets('subtitle has letter-spacing in title style', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(title: 'LABEL', subtitle: 'Detail'),
      );
      final titleWidget = tester.widget<Text>(find.text('LABEL'));
      expect(titleWidget.style?.letterSpacing, 2.0);
    });
  });
}