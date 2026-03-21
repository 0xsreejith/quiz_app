import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/widgets/common_app_bar.dart';

void main() {
  Widget buildTestWidget(CommonAppBar appBar) {
    return MaterialApp(
      home: Scaffold(appBar: appBar),
    );
  }

  group('CommonAppBar - Title', () {
    testWidgets('displays the provided title text', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(const CommonAppBar(title: 'Quiz')),
      );
      expect(find.text('Quiz'), findsOneWidget);
    });

    testWidgets('displays a different title correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(const CommonAppBar(title: 'History')),
      );
      expect(find.text('History'), findsOneWidget);
    });
  });

  group('CommonAppBar - centerTitle default', () {
    testWidgets('centers title by default', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(const CommonAppBar(title: 'Test')),
      );
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.centerTitle, isTrue);
    });

    testWidgets('respects centerTitle = false', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const CommonAppBar(title: 'Test', centerTitle: false),
        ),
      );
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.centerTitle, isFalse);
    });
  });

  group('CommonAppBar - Actions', () {
    testWidgets('shows no action buttons when actions is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(const CommonAppBar(title: 'Test')),
      );
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.actions, isNull);
    });

    testWidgets('shows provided action widgets', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const CommonAppBar(
            title: 'Test',
            actions: [Icon(Icons.settings)],
          ),
        ),
      );
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('shows multiple action widgets', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const CommonAppBar(
            title: 'Test',
            actions: [
              Icon(Icons.search),
              Icon(Icons.more_vert),
            ],
          ),
        ),
      );
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });
  });

  group('CommonAppBar - Leading', () {
    testWidgets('shows no leading when not provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(const CommonAppBar(title: 'Test')),
      );
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.leading, isNull);
    });

    testWidgets('shows provided leading widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const CommonAppBar(
            title: 'Test',
            leading: Icon(Icons.arrow_back),
          ),
        ),
      );
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });
  });

  group('CommonAppBar - PreferredSizeWidget', () {
    test('preferredSize height equals kToolbarHeight', () {
      const appBar = CommonAppBar(title: 'Test');
      expect(appBar.preferredSize.height, kToolbarHeight);
    });

    test('preferredSize width is double.infinity', () {
      const appBar = CommonAppBar(title: 'Test');
      expect(appBar.preferredSize.width, double.infinity);
    });

    test('implements PreferredSizeWidget', () {
      const appBar = CommonAppBar(title: 'Test');
      expect(appBar, isA<PreferredSizeWidget>());
    });
  });

  group('CommonAppBar - Renders AppBar', () {
    testWidgets('contains exactly one AppBar', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(const CommonAppBar(title: 'Test')),
      );
      expect(find.byType(AppBar), findsOneWidget);
    });
  });
}