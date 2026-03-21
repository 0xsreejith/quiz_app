import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/widgets/info_card.dart';

Widget _buildInfoCard({
  String header = 'BEST PERFORMANCE',
  Widget child = const Text('Child content'),
}) {
  return MaterialApp(
    home: Scaffold(
      body: InfoCard(
        header: header,
        child: child,
      ),
    ),
  );
}

void main() {
  group('InfoCard — rendering', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(_buildInfoCard());
      expect(find.byType(InfoCard), findsOneWidget);
    });

    testWidgets('displays the header text', (tester) async {
      await tester.pumpWidget(_buildInfoCard(header: 'BEST PERFORMANCE'));
      expect(find.text('BEST PERFORMANCE'), findsOneWidget);
    });

    testWidgets('displays different header text correctly', (tester) async {
      await tester.pumpWidget(_buildInfoCard(header: 'DOMINANT FIELD'));
      expect(find.text('DOMINANT FIELD'), findsOneWidget);
    });

    testWidgets('renders the child widget', (tester) async {
      await tester.pumpWidget(_buildInfoCard(
        child: const Text('Child content here'),
      ));
      expect(find.text('Child content here'), findsOneWidget);
    });

    testWidgets('renders complex child widget', (tester) async {
      await tester.pumpWidget(_buildInfoCard(
        child: Column(
          children: const [
            Text('Row 1'),
            Text('Row 2'),
          ],
        ),
      ));
      expect(find.text('Row 1'), findsOneWidget);
      expect(find.text('Row 2'), findsOneWidget);
    });
  });

  group('InfoCard — decoration', () {
    testWidgets('outer container uses white background via BoxDecoration', (tester) async {
      await tester.pumpWidget(_buildInfoCard());
      final containers = tester.widgetList<Container>(find.byType(Container)).toList();
      final whiteContainers = containers.where((c) {
        final deco = c.decoration;
        return deco is BoxDecoration && deco.color == Colors.white;
      }).toList();
      expect(whiteContainers, isNotEmpty);
    });

    testWidgets('outer container has correct border radius', (tester) async {
      await tester.pumpWidget(_buildInfoCard());
      final containers = tester.widgetList<Container>(find.byType(Container)).toList();
      // Find a container with BoxDecoration that has a borderRadius
      final decoratedContainers = containers.where((c) {
        final decoration = c.decoration;
        if (decoration is BoxDecoration) {
          return decoration.borderRadius != null;
        }
        return false;
      }).toList();
      expect(decoratedContainers, isNotEmpty);
      final boxDecoration = decoratedContainers.first.decoration as BoxDecoration;
      expect(
        boxDecoration.borderRadius,
        equals(BorderRadius.circular(AppSpacing.cardRadius)),
      );
    });

    testWidgets('outer container has a border', (tester) async {
      await tester.pumpWidget(_buildInfoCard());
      final containers = tester.widgetList<Container>(find.byType(Container)).toList();
      final borderedContainers = containers.where((c) {
        final decoration = c.decoration;
        if (decoration is BoxDecoration) {
          return decoration.border != null;
        }
        return false;
      }).toList();
      expect(borderedContainers, isNotEmpty);
      final boxDecoration = borderedContainers.first.decoration as BoxDecoration;
      expect(
        boxDecoration.border,
        equals(Border.all(color: AppColors.divider)),
      );
    });
  });

  group('InfoCard — layout', () {
    testWidgets('header appears before child content', (tester) async {
      await tester.pumpWidget(_buildInfoCard(
        header: 'HEADER',
        child: const Text('BODY'),
      ));
      final headerOffset = tester.getTopLeft(find.text('HEADER'));
      final bodyOffset = tester.getTopLeft(find.text('BODY'));
      expect(headerOffset.dy, lessThan(bodyOffset.dy));
    });

    testWidgets('card occupies full available width', (tester) async {
      await tester.pumpWidget(_buildInfoCard());
      final infoCard = tester.getSize(find.byType(InfoCard));
      final scaffoldBody = tester.getSize(find.byType(Scaffold));
      // InfoCard should fill the available width (Scaffold width)
      expect(infoCard.width, equals(scaffoldBody.width));
    });
  });

  group('InfoCard — header text style', () {
    testWidgets('header uses miniLabel style (fontSize 10)', (tester) async {
      await tester.pumpWidget(_buildInfoCard(header: 'STATS'));
      final headerText = tester.widget<Text>(find.text('STATS'));
      expect(headerText.style?.fontSize, equals(10.0));
    });

    testWidgets('header uses miniLabel style (fontWeight w700)', (tester) async {
      await tester.pumpWidget(_buildInfoCard(header: 'STATS'));
      final headerText = tester.widget<Text>(find.text('STATS'));
      expect(headerText.style?.fontWeight, equals(FontWeight.w700));
    });
  });

  group('InfoCard — edge cases', () {
    testWidgets('handles empty header string', (tester) async {
      await tester.pumpWidget(_buildInfoCard(header: ''));
      expect(find.byType(InfoCard), findsOneWidget);
    });

    testWidgets('handles long header without overflow', (tester) async {
      await tester.pumpWidget(_buildInfoCard(
        header: 'THIS IS A VERY LONG HEADER LABEL THAT MIGHT NEED TO WRAP',
      ));
      expect(find.byType(InfoCard), findsOneWidget);
    });

    testWidgets('renders with an icon as child', (tester) async {
      await tester.pumpWidget(_buildInfoCard(
        child: const Icon(Icons.star),
      ));
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('renders multiple info cards in a column', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                InfoCard(header: 'FIRST CARD', child: Text('Content 1')),
                InfoCard(header: 'SECOND CARD', child: Text('Content 2')),
              ],
            ),
          ),
        ),
      );
      expect(find.text('FIRST CARD'), findsOneWidget);
      expect(find.text('SECOND CARD'), findsOneWidget);
      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsOneWidget);
    });
  });
}