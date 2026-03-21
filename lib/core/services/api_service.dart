import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.example.com'; // Replace with your actual API
  
  static Future<Map<String, dynamic>> getFeaturedQuizzes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/quizzes/featured'));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load featured quizzes');
      }
    } catch (e) {
      // Return mock data for now
      return _getMockFeaturedQuizzes();
    }
  }
  
  static Future<Map<String, dynamic>> getLiveSessions() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/sessions/live'));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load live sessions');
      }
    } catch (e) {
      // Return mock data for now
      return _getMockLiveSessions();
    }
  }
  
  static Future<Map<String, dynamic>> getTopPerformers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/top-performers'));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load top performers');
      }
    } catch (e) {
      // Return mock data for now
      return _getMockTopPerformers();
    }
  }
  
  static Future<Map<String, dynamic>> getRecentActivity(String userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/$userId/activity'));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load recent activity');
      }
    } catch (e) {
      // Return mock data for now
      return _getMockRecentActivity();
    }
  }
  
  static Future<Map<String, dynamic>> searchQuizzes(String query) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/quizzes/search?q=$query'));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to search quizzes');
      }
    } catch (e) {
      // Return mock data for now
      return _getMockSearchResults(query);
    }
  }
  
  // Mock data methods
  static Map<String, dynamic> _getMockFeaturedQuizzes() {
    return {
      'success': true,
      'data': [
        {
          'id': '1',
          'title': 'Advanced React Architecture',
          'category': 'DEVELOPMENT',
          'difficulty': 'EXPERT',
          'players': 2400,
          'imageUrl': 'https://picsum.photos/seed/react1/200/150.jpg',
          'rating': 4.8,
          'duration': 30,
        }
      ]
    };
  }
  
  static Map<String, dynamic> _getMockLiveSessions() {
    return {
      'success': true,
      'data': [
        {
          'id': '1',
          'title': 'React Hooks Deep Dive',
          'host': 'Sarah Chen',
          'startsIn': 5,
          'waitingCount': 142,
          'maxParticipants': 500,
          'isLive': true,
        }
      ]
    };
  }
  
  static Map<String, dynamic> _getMockTopPerformers() {
    return {
      'success': true,
      'data': [
        {
          'id': '1',
          'name': 'Sarah Jenkins',
          'level': 42,
          'title': 'Master',
          'points': 38420,
          'avatarUrl': 'https://picsum.photos/seed/sarah/50/50.jpg',
          'badge': '🏆',
        },
        {
          'id': '2',
          'name': 'Alex P.',
          'level': 38,
          'title': 'On Fire',
          'points': 36250,
          'avatarUrl': 'https://picsum.photos/seed/alex/50/50.jpg',
          'badge': '🔥',
          'isCurrentUser': true,
        },
        {
          'id': '3',
          'name': 'Mike Ross',
          'level': 35,
          'title': 'Top Contributor',
          'points': 34180,
          'avatarUrl': 'https://picsum.photos/seed/mike/50/50.jpg',
          'badge': '⭐',
        }
      ]
    };
  }
  
  static Map<String, dynamic> _getMockRecentActivity() {
    return {
      'success': true,
      'data': [
        {
          'id': '1',
          'quizTitle': 'React Hooks Quiz',
          'completedAt': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
          'status': 'PASSED',
          'accuracy': 92,
          'score': 184,
          'totalQuestions': 20,
        },
        {
          'id': '2',
          'quizTitle': 'Typography Basics',
          'completedAt': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
          'status': 'PASSED',
          'accuracy': 84,
          'score': 168,
          'totalQuestions': 20,
        }
      ]
    };
  }
  
  static Map<String, dynamic> _getMockSearchResults(String query) {
    return {
      'success': true,
      'data': [
        {
          'id': '1',
          'title': 'React Fundamentals',
          'category': 'DEVELOPMENT',
          'difficulty': 'BEGINNER',
          'players': 1200,
        }
      ]
    };
  }
}
