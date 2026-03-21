import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/widgets/common_app_bar.dart';

Widget _buildWithAppBar(CommonAppBar appBar) {
  return MaterialApp(
    home: Scaffold(appBar: appBar),
  );
}

void main() {
  group('CommonAppBar — rendering', () {
    testWidgets('renders without throwing', (tester) async {
      await tester.pumpWidget(_buildWithAppBar(
        const CommonAppBar(title: 'Test Title'),
      ));
      expect(find.byType(CommonAppBar), findsOneWidget);
    });

    testWidgets('renders an AppBar', (tester) async {
      await tester.pumpWidget(_buildWithAppBar(
        const CommonAppBar(title: 'My App'),
      ));
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('displays the provided title text', (tester) async {
      await tester.pumpWidget(_buildWithAppBar(
        const CommonAppBar(title: 'Quiz History'),
      ));
      expect(find.text('Quiz History'), findsOneWidget);
    });

    testWidgets('displays different title text correctly', (tester) async {
      await tester.pumpWidget(_buildWithAppBar(
        const CommonAppBar(title: 'Leaderboard'),
      ));
      expect(find.text('Leaderboard'), findsOneWidget);
    });
  });

  group('CommonAppBar — preferredSize', () {
    test('preferredSize height equals kToolbarHeight', () {
      const appBar = CommonAppBar(title: 'Test');
      expect(appBar.preferredSize.height, equals(kToolbarHeight));
    });

    test('preferredSize is a Size object', () {
      const appBar = CommonAppBar(title: 'Test');
      expect(appBar.preferredSize, isA<Size>());
    });

    test('implements PreferredSizeWidget', () {
      const appBar = CommonAppBar(title: 'Test');
      expect(appBar, isA<PreferredSizeWidget>());
    });
  });

  group('CommonAppBar — centerTitle', () {
    testWidgets('centerTitle defaults to true', (tester) async {
      await tester.pumpWidget(_buildWithAppBar(
        const CommonAppBar(title: 'Centered'),
      ));
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.centerTitle, isTrue);
    });

    testWidgets('centerTitle can be set to false', (tester) async {
      await tester.pumpWidget(_buildWithAppBar(
        const CommonAppBar(title: 'Left Aligned', centerTitle: false),
      ));
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.centerTitle, isFalse);
    });
  });

  group('CommonAppBar — actions', () {
    testWidgets('renders no actions when none provided', (tester) async {
      await tester.pumpWidget(_buildWithAppBar(
        const CommonAppBar(title: 'No Actions'),
      ));
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.actions, isNull);
    });

    testWidgets('renders provided action widgets', (tester) async {
      await tester.pumpWidget(_buildWithAppBar(
        const CommonAppBar(
          title: 'With Actions',
          actions: [
            Icon(Icons.search),
            Icon(Icons.settings),
          ],
        ),
      ));
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('single action widget is rendered correctly', (tester) async {
      await tester.pumpWidget(_buildWithAppBar(
        const CommonAppBar(
          title: 'With Icon',
          actions: [Icon(Icons.more_vert)],
        ),
      ));
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });
  });

  group('CommonAppBar — leading', () {
    testWidgets('renders no custom leading when not provided', (tester) async {
      await tester.pumpWidget(_buildWithAppBar(
        const CommonAppBar(title: 'No Leading'),
      ));
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.leading, isNull);
    });

    testWidgets('renders provided leading widget', (tester) async {
      await tester.pumpWidget(_buildWithAppBar(
        const CommonAppBar(
          title: 'With Leading',
          leading: Icon(Icons.arrow_back),
        ),
      ));
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });
  });

  group('CommonAppBar — empty title', () {
    testWidgets('handles empty string title', (tester) async {
      await tester.pumpWidget(_buildWithAppBar(
        const CommonAppBar(title: ''),
      ));
      expect(find.byType(CommonAppBar), findsOneWidget);
    });
  });
}