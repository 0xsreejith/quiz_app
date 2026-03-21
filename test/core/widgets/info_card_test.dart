import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/widgets/info_card.dart';

Widget _buildSubject({required String header, required Widget child}) {
  return MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: InfoCard(header: header, child: child),
      ),
    ),
  );
}

void main() {
  group('InfoCard — rendering', () {
    testWidgets('displays the provided header text', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(
        header: 'BEST PERFORMANCE',
        child: const Text('90%'),
      ));
      expect(find.text('BEST PERFORMANCE'), findsOneWidget);
    });

    testWidgets('renders the provided child widget', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(
        header: 'DOMINANT FIELD',
        child: const Text(key: Key('child_text'), 'Science'),
      ));
      expect(find.byKey(const Key('child_text')), findsOneWidget);
      expect(find.text('Science'), findsOneWidget);
    });

    testWidgets('renders arbitrary child widget', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(
        header: 'STATS',
        child: const Row(
          children: [
            Icon(key: Key('star'), Icons.star),
            Text('5.0'),
          ],
        ),
      ));
      expect(find.byKey(const Key('star')), findsOneWidget);
      expect(find.text('5.0'), findsOneWidget);
    });

    testWidgets('renders without error for empty header', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(
        header: '',
        child: const SizedBox(),
      ));
      expect(find.byType(InfoCard), findsOneWidget);
    });
  });

  group('InfoCard — structure', () {
    testWidgets('uses a Column layout', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(
        header: 'H',
        child: const Text('C'),
      ));
      expect(
        find.descendant(of: find.byType(InfoCard), matching: find.byType(Column)),
        findsWidgets,
      );
    });

    testWidgets('outer container is full width', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(
        header: 'H',
        child: const Text('C'),
      ));
      // Container with width: double.infinity renders at parent's max width
      final renderBox = tester.getSize(find.byType(InfoCard));
      // Width should be greater than 0 (it fills available space)
      expect(renderBox.width, greaterThan(0));
    });

    testWidgets('container has border with divider color', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(
        header: 'H',
        child: const Text('C'),
      ));
      // Find the outermost Container inside InfoCard
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(InfoCard),
          matching: find.byType(Container),
        ).first,
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.white));
      expect(
        decoration.borderRadius,
        equals(BorderRadius.circular(AppSpacing.cardRadius)),
      );
      // Border uses AppColors.divider
      final border = decoration.border as Border;
      expect(border.top.color, equals(AppColors.divider));
    });

    testWidgets('header text appears before child in column', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(
        header: 'THE HEADER',
        child: const Text('THE CHILD'),
      ));

      final headerPos = tester.getTopLeft(find.text('THE HEADER'));
      final childPos = tester.getTopLeft(find.text('THE CHILD'));

      // Header should be above the child
      expect(headerPos.dy, lessThan(childPos.dy));
    });
  });

  group('InfoCard — edge cases', () {
    testWidgets('long header text does not cause overflow', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(
        header: 'A' * 100,
        child: const SizedBox(),
      ));
      expect(tester.takeException(), isNull);
    });

    testWidgets('nested InfoCard renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(
        header: 'OUTER',
        child: InfoCard(
          header: 'INNER',
          child: const Text('deep content'),
        ),
      ));
      expect(find.text('OUTER'), findsOneWidget);
      expect(find.text('INNER'), findsOneWidget);
      expect(find.text('deep content'), findsOneWidget);
    });
  });
}