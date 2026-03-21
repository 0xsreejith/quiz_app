import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/widgets/info_card.dart';

void main() {
  Widget buildTestWidget({required String header, required Widget child}) {
    return MaterialApp(
      home: Scaffold(
        body: InfoCard(header: header, child: child),
      ),
    );
  }

  group('InfoCard - Header', () {
    testWidgets('renders header text', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          header: 'BEST PERFORMANCE',
          child: const Text('Content'),
        ),
      );
      expect(find.text('BEST PERFORMANCE'), findsOneWidget);
    });

    testWidgets('renders different header text', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          header: 'DOMINANT FIELD',
          child: const Text('Content'),
        ),
      );
      expect(find.text('DOMINANT FIELD'), findsOneWidget);
    });
  });

  group('InfoCard - Child content', () {
    testWidgets('renders the child widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          header: 'HEADER',
          child: const Text('Child content text'),
        ),
      );
      expect(find.text('Child content text'), findsOneWidget);
    });

    testWidgets('renders complex child widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          header: 'HEADER',
          child: const Column(
            children: [
              Text('Line 1'),
              Text('Line 2'),
            ],
          ),
        ),
      );
      expect(find.text('Line 1'), findsOneWidget);
      expect(find.text('Line 2'), findsOneWidget);
    });

    testWidgets('renders an Icon as child', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          header: 'HEADER',
          child: const Icon(Icons.star),
        ),
      );
      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });

  group('InfoCard - Layout and styling', () {
    testWidgets('uses a Container as the root widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(header: 'H', child: const Text('c')),
      );
      // InfoCard root is a Container
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('uses Column layout internally', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(header: 'H', child: const Text('c')),
      );
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('container has white background color', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(header: 'H', child: const SizedBox()),
      );
      // The root Container of InfoCard has a BoxDecoration with white background
      final containers = tester.widgetList<Container>(
        find.descendant(
          of: find.byType(InfoCard),
          matching: find.byType(Container),
        ),
      );
      final rootContainer = containers.first;
      final decoration = rootContainer.decoration as BoxDecoration;
      expect(decoration.color, Colors.white);
    });

    testWidgets('container has correct border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(header: 'H', child: const SizedBox()),
      );
      final containers = tester.widgetList<Container>(
        find.descendant(
          of: find.byType(InfoCard),
          matching: find.byType(Container),
        ),
      );
      final rootContainer = containers.first;
      final decoration = rootContainer.decoration as BoxDecoration;
      expect(
        decoration.borderRadius,
        BorderRadius.circular(AppSpacing.cardRadius),
      );
    });

    testWidgets('container has border with divider color', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(header: 'H', child: const SizedBox()),
      );
      final containers = tester.widgetList<Container>(
        find.descendant(
          of: find.byType(InfoCard),
          matching: find.byType(Container),
        ),
      );
      final rootContainer = containers.first;
      final decoration = rootContainer.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.top.color, AppColors.divider);
    });

    testWidgets('header text has correct font size (10)', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(header: 'MY HEADER', child: const SizedBox()),
      );
      final headerText = tester.widget<Text>(find.text('MY HEADER'));
      expect(headerText.style?.fontSize, 10.0);
    });

    testWidgets('header text has bold font weight (w700)', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(header: 'MY HEADER', child: const SizedBox()),
      );
      final headerText = tester.widget<Text>(find.text('MY HEADER'));
      expect(headerText.style?.fontWeight, FontWeight.w700);
    });
  });

  group('InfoCard - Width', () {
    testWidgets('container has double.infinity width', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(header: 'H', child: const SizedBox()),
      );
      final containers = tester.widgetList<Container>(
        find.descendant(
          of: find.byType(InfoCard),
          matching: find.byType(Container),
        ),
      );
      final rootContainer = containers.first;
      expect(rootContainer.constraints?.maxWidth, double.infinity);
    });
  });
}