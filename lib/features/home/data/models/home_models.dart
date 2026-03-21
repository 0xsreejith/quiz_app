class FeaturedQuiz {
  final String id;
  final String title;
  final String category;
  final String difficulty;
  final int players;
  final String imageUrl;
  final double rating;
  final int duration;

  FeaturedQuiz({
    required this.id,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.players,
    required this.imageUrl,
    required this.rating,
    required this.duration,
  });

  factory FeaturedQuiz.fromJson(Map<String, dynamic> json) {
    return FeaturedQuiz(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      difficulty: json['difficulty'],
      players: json['players'],
      imageUrl: json['imageUrl'] ?? '',
      rating: json['rating']?.toDouble() ?? 0.0,
      duration: json['duration'],
    );
  }

  String get formattedPlayers {
    if (players >= 1000) {
      return '${(players / 1000).toStringAsFixed(1)}k Players';
    }
    return '$players Players';
  }
}

class LiveSession {
  final String id;
  final String title;
  final String host;
  final int startsIn;
  final int waitingCount;
  final int maxParticipants;
  final bool isLive;

  LiveSession({
    required this.id,
    required this.title,
    required this.host,
    required this.startsIn,
    required this.waitingCount,
    required this.maxParticipants,
    required this.isLive,
  });

  factory LiveSession.fromJson(Map<String, dynamic> json) {
    return LiveSession(
      id: json['id'],
      title: json['title'],
      host: json['host'],
      startsIn: json['startsIn'],
      waitingCount: json['waitingCount'],
      maxParticipants: json['maxParticipants'],
      isLive: json['isLive'] ?? false,
    );
  }

  String get formattedStartsIn {
    if (startsIn <= 0) return 'NOW';
    return '${startsIn}M';
  }

  String get formattedWaitingCount {
    return '$waitingCount WAITING';
  }
}

class TopPerformer {
  final String id;
  final String name;
  final int level;
  final String title;
  final int points;
  final String avatarUrl;
  final String badge;
  final bool isCurrentUser;

  TopPerformer({
    required this.id,
    required this.name,
    required this.level,
    required this.title,
    required this.points,
    required this.avatarUrl,
    required this.badge,
    this.isCurrentUser = false,
  });

  factory TopPerformer.fromJson(Map<String, dynamic> json) {
    return TopPerformer(
      id: json['id'],
      name: json['name'],
      level: json['level'],
      title: json['title'],
      points: json['points'],
      avatarUrl: json['avatarUrl'] ?? '',
      badge: json['badge'] ?? '',
      isCurrentUser: json['isCurrentUser'] ?? false,
    );
  }

  String get formattedPoints {
    return '${points.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )} pts';
  }

  String get displayName {
    if (isCurrentUser) return '$name (You)';
    return name;
  }
}

class RecentActivity {
  final String id;
  final String quizTitle;
  final DateTime completedAt;
  final String status;
  final int accuracy;
  final int score;
  final int totalQuestions;

  RecentActivity({
    required this.id,
    required this.quizTitle,
    required this.completedAt,
    required this.status,
    required this.accuracy,
    required this.score,
    required this.totalQuestions,
  });

  factory RecentActivity.fromJson(Map<String, dynamic> json) {
    return RecentActivity(
      id: json['id'],
      quizTitle: json['quizTitle'],
      completedAt: DateTime.parse(json['completedAt']),
      status: json['status'],
      accuracy: json['accuracy'],
      score: json['score'],
      totalQuestions: json['totalQuestions'],
    );
  }

  String get formattedAccuracy => '$accuracy% ACCURACY';
  
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(completedAt);
    
    if (difference.inHours < 1) {
      final minutes = difference.inMinutes;
      return minutes <= 1 ? 'JUST NOW' : '$minutes MINUTES AGO';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} HOURS AGO';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} DAYS AGO';
    } else {
      return '${difference.inDays ~/ 7} WEEKS AGO';
    }
  }
}

class SearchResult {
  final String id;
  final String title;
  final String category;
  final String difficulty;
  final int players;

  SearchResult({
    required this.id,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.players,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      difficulty: json['difficulty'],
      players: json['players'],
    );
  }
}
