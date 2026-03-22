abstract final class BadgeDefinitions {
  static const Map<String, Map<String, dynamic>> global =
      <String, Map<String, dynamic>>{
        'quiz_god': <String, dynamic>{
          'emoji': '🌟',
          'label': 'God Tier',
          'color': 0xFFFFD700,
          'minScore': 5000,
        },
        'quiz_legend': <String, dynamic>{
          'emoji': '👑',
          'label': 'Legend',
          'color': 0xFF9B59B6,
          'minScore': 2500,
        },
        'quiz_champion': <String, dynamic>{
          'emoji': '🏆',
          'label': 'Champion',
          'color': 0xFFD4AF37,
          'minScore': 1000,
        },
        'quiz_master': <String, dynamic>{
          'emoji': '🔥',
          'label': 'Master',
          'color': 0xFFE74C3C,
          'minScore': 500,
        },
        'quiz_expert': <String, dynamic>{
          'emoji': '⚡',
          'label': 'Expert',
          'color': 0xFF3498DB,
          'minScore': 250,
        },
        'quiz_scholar': <String, dynamic>{
          'emoji': '🎓',
          'label': 'Scholar',
          'color': 0xFF2ECC71,
          'minScore': 100,
        },
        'quiz_apprentice': <String, dynamic>{
          'emoji': '📘',
          'label': 'Apprentice',
          'color': 0xFF1ABC9C,
          'minScore': 50,
        },
        'quiz_novice': <String, dynamic>{
          'emoji': '🌱',
          'label': 'Novice',
          'color': 0xFF95A5A6,
          'minScore': 10,
        },
        'unranked': <String, dynamic>{
          'emoji': '—',
          'label': 'Unranked',
          'color': 0xFFBDC3C7,
          'minScore': 0,
        },
      };

  static const Map<String, Map<String, dynamic>> streak =
      <String, Map<String, dynamic>>{
        'centurion_100': <String, dynamic>{
          'emoji': '🎖️',
          'label': 'Centurion',
          'color': 0xFFD4AF37,
        },
        'elite_50': <String, dynamic>{
          'emoji': '💎',
          'label': 'Elite',
          'color': 0xFF9B59B6,
        },
        'veteran_25': <String, dynamic>{
          'emoji': '🛡️',
          'label': 'Veteran',
          'color': 0xFF2C3E50,
        },
        'committed_10': <String, dynamic>{
          'emoji': '🔑',
          'label': 'Committed',
          'color': 0xFF3498DB,
        },
        'dedicated_5': <String, dynamic>{
          'emoji': '💪',
          'label': 'Dedicated',
          'color': 0xFF27AE60,
        },
        'first_attempt': <String, dynamic>{
          'emoji': '🎯',
          'label': 'First Attempt',
          'color': 0xFF7F8C8D,
        },
      };

  static const Map<String, Map<String, dynamic>> accuracy =
      <String, Map<String, dynamic>>{
        'perfectionist': <String, dynamic>{
          'emoji': '✨',
          'label': 'Perfectionist',
          'color': 0xFFE74C3C,
        },
        'precision_80': <String, dynamic>{
          'emoji': '🎯',
          'label': 'Precision',
          'color': 0xFFE67E22,
        },
        'sharp_mind': <String, dynamic>{
          'emoji': '🧠',
          'label': 'Sharp Mind',
          'color': 0xFF3498DB,
        },
      };

  static Map<String, dynamic>? getGlobal(String key) => global[key];

  static Map<String, dynamic>? getAny(String key) =>
      global[key] ?? streak[key] ?? accuracy[key];

  static String getNextGlobalBadge(int totalScore) {
    if (totalScore < 10) {
      return 'quiz_novice (need ${10 - totalScore} more pts)';
    }
    if (totalScore < 50) {
      return 'quiz_apprentice (need ${50 - totalScore} more pts)';
    }
    if (totalScore < 100) {
      return 'quiz_scholar (need ${100 - totalScore} more pts)';
    }
    if (totalScore < 250) {
      return 'quiz_expert (need ${250 - totalScore} more pts)';
    }
    if (totalScore < 500) {
      return 'quiz_master (need ${500 - totalScore} more pts)';
    }
    if (totalScore < 1000) {
      return 'quiz_champion (need ${1000 - totalScore} more pts)';
    }
    if (totalScore < 2500) {
      return 'quiz_legend (need ${2500 - totalScore} more pts)';
    }
    if (totalScore < 5000) {
      return 'quiz_god (need ${5000 - totalScore} more pts)';
    }
    return 'MAX TIER REACHED';
  }
}
