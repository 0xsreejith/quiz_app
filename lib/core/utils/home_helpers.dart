import 'package:flutter/material.dart';

/// Static mock display data for the home screen UI preview.
/// No backend logic, no models — plain data for display only.
abstract final class HomeHelpers {
  /// Featured quiz carousel items.
  static const List<Map<String, dynamic>> featuredQuizzes = [
    {
      'title': 'Advanced React\nArchitecture',
      'description': 'Master server components,\nhydration strategies, and...',
      'category': 'EXPERT · DEVELOPMENT',
      'players': '2.4k Players',
    },
    {
      'title': 'Flutter State\nManagement',
      'description': 'Deep dive into Riverpod,\nBloc, and GetX patterns...',
      'category': 'INTERMEDIATE · MOBILE',
      'players': '1.8k Players',
    },
    {
      'title': 'System Design\nFundamentals',
      'description': 'Scalability, load balancing,\ncaching strategies...',
      'category': 'ADVANCED · ARCHITECTURE',
      'players': '3.1k Players',
    },
  ];

  /// Category panel items.
  static const List<Map<String, dynamic>> categories = [
    {
      'icon': Icons.code,
      'title': 'Development',
      'subtitle': 'TRENDING NOW',
      'meta': '12K PLAYS',
    },
    {
      'icon': Icons.palette_outlined,
      'title': 'Design',
      'subtitle': '3 NEW QUIZZES',
      'meta': 'UPDATED TODAY',
    },
    {
      'icon': Icons.history_edu,
      'title': 'History',
      'subtitle': 'POPULAR THIS WEEK',
      'meta': '',
    },
  ];

  /// Live session mock data.
  static const Map<String, String> liveSession = {
    'title': 'React Hooks\nDeep Dive',
    'startsIn': 'STARTS IN\n5M',
    'waiting': '142\nWAITING',
  };

  /// Top performers list.
  static const List<Map<String, dynamic>> topPerformers = [
    {
      'rank': '01',
      'name': 'Sarah Jenkins',
      'subtitle': 'LEVEL 42 MASTER',
      'points': '38,420',
      'isCurrentUser': false,
    },
    {
      'rank': '02',
      'name': 'Alex P. (You)',
      'subtitle': 'ON FIRE 🔥',
      'points': '36,250',
      'isCurrentUser': true,
    },
    {
      'rank': '03',
      'name': 'Mike Ross',
      'subtitle': 'TOP CONTRIBUTOR',
      'points': '34,180',
      'isCurrentUser': false,
    },
  ];

  /// Recent activity items.
  static const List<Map<String, String>> recentActivities = [
    {
      'title': 'React Hooks Quiz',
      'meta': '2 HOURS AGO  ·  PASSED',
      'accuracy': '92%',
    },
    {
      'title': 'Typography Basics',
      'meta': 'YESTERDAY  ·  PASSED',
      'accuracy': '84%',
    },
  ];

  /// Total category count for the "VIEW ALL" footer.
  static const int totalCategoryCount = 24;
}
