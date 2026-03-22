import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/services/auth_service.dart';
import 'package:quiz_app/core/services/firestore_service.dart';

class LeaderboardController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final AuthService _authService = Get.find<AuthService>();

  final RxList<Map<String, dynamic>> scores = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final RxnString errorMessage = RxnString();

  /// The signed-in user's own score document (fetched separately).
  final Rxn<Map<String, dynamic>> userScoreDoc = Rxn<Map<String, dynamic>>();

  /// The user's authoritative global rank (not limited to top-50).
  final RxInt userGlobalRank = 0.obs;
  final RxInt totalRankedUsers = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLeaderboard();
  }

  Future<void> fetchLeaderboard() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final String? uid = _authService.currentUser?.uid;

      if (uid != null) {
        final List<Object?> results = await Future.wait(<Future<Object?>>[
          _firestoreService.getTopScores(limit: 50),
          _firestoreService.getUserScoreDoc(uid),
          _firestoreService.getUserGlobalRank(uid),
          _firestoreService.getRankedUserCount(),
        ]);

        scores.assignAll(results[0] as List<Map<String, dynamic>>);
        userScoreDoc.value = results[1] as Map<String, dynamic>?;
        userGlobalRank.value = results[2] as int;
        totalRankedUsers.value = results[3] as int;
      } else {
        final List<Object> results = await Future.wait(<Future<Object>>[
          _firestoreService.getTopScores(limit: 50),
          _firestoreService.getRankedUserCount(),
        ]);
        scores.assignAll(results[0] as List<Map<String, dynamic>>);
        totalRankedUsers.value = results[1] as int;
      }
    } on FirebaseException catch (error) {
      errorMessage.value = _buildErrorMessage(error);
    } catch (_) {
      errorMessage.value = 'Unable to load leaderboard data right now.';
    } finally {
      isLoading.value = false;
    }
  }

  String _buildErrorMessage(FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return 'Leaderboard access is blocked by current Firestore rules.';
      case 'unavailable':
        return 'The leaderboard service is temporarily unavailable.';
      default:
        return 'Unable to load leaderboard data right now.';
    }
  }
}
