import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/widgets/common_app_bar.dart';

Widget _buildScaffold(CommonAppBar appBar) {
  return MaterialApp(
    home: Scaffold(appBar: appBar),
  );
}

void main() {
  group('CommonAppBar — preferredSize', () {
    test('preferredSize height equals kToolbarHeight', () {
      const bar = CommonAppBar(title: 'Test');
      expect(bar.preferredSize.height, equals(kToolbarHeight));
    });

    test('preferredSize width is double.infinity', () {
      const bar = CommonAppBar(title: 'Test');
      expect(bar.preferredSize.width, equals(double.infinity));
    });
  });

  group('CommonAppBar — title rendering', () {
    testWidgets('displays the provided title text', (WidgetTester tester) async {
      await tester.pumpWidget(_buildScaffold(const CommonAppBar(title: 'Quiz History')));
      expect(find.text('Quiz History'), findsOneWidget);
    });

    testWidgets('displays empty string title without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(_buildScaffold(const CommonAppBar(title: '')));
      expect(find.byType(AppBar), findsOneWidget);
    });
  });

  group('CommonAppBar — centerTitle', () {
    testWidgets('centerTitle defaults to true', (WidgetTester tester) async {
      await tester.pumpWidget(_buildScaffold(const CommonAppBar(title: 'T')));
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.centerTitle, isTrue);
    });

    testWidgets('centerTitle can be set to false', (WidgetTester tester) async {
      await tester.pumpWidget(
        _buildScaffold(const CommonAppBar(title: 'T', centerTitle: false)),
      );
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.centerTitle, isFalse);
    });
  });

  group('CommonAppBar — actions', () {
    testWidgets('renders no actions when none provided', (WidgetTester tester) async {
      await tester.pumpWidget(_buildScaffold(const CommonAppBar(title: 'T')));
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.actions, isNull);
    });

    testWidgets('renders provided action widgets', (WidgetTester tester) async {
      await tester.pumpWidget(_buildScaffold(
        CommonAppBar(
          title: 'T',
          actions: [
            IconButton(
              key: const Key('action_btn'),
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
      ));
      expect(find.byKey(const Key('action_btn')), findsOneWidget);
    });

    testWidgets('multiple action widgets all render', (WidgetTester tester) async {
      await tester.pumpWidget(_buildScaffold(
        CommonAppBar(
          title: 'T',
          actions: [
            IconButton(
              key: const Key('btn1'),
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              key: const Key('btn2'),
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
      ));
      expect(find.byKey(const Key('btn1')), findsOneWidget);
      expect(find.byKey(const Key('btn2')), findsOneWidget);
    });
  });

  group('CommonAppBar — leading', () {
    testWidgets('renders no leading widget by default', (WidgetTester tester) async {
      await tester.pumpWidget(_buildScaffold(const CommonAppBar(title: 'T')));
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.leading, isNull);
    });

    testWidgets('renders provided leading widget', (WidgetTester tester) async {
      await tester.pumpWidget(_buildScaffold(
        CommonAppBar(
          title: 'T',
          leading: IconButton(
            key: const Key('back_btn'),
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
        ),
      ));
      expect(find.byKey(const Key('back_btn')), findsOneWidget);
    });
  });

  group('CommonAppBar — implements PreferredSizeWidget', () {
    test('is a PreferredSizeWidget', () {
      const bar = CommonAppBar(title: 'Test');
      expect(bar, isA<PreferredSizeWidget>());
    });
  });
}