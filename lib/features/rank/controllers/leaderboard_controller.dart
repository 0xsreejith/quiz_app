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

  /// The signed-in user's own leaderboard document.
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
        final Map<String, dynamic> bundle =
            await _firestoreService.getLeaderboardBundle(
          uid: uid,
          displayLimit: 50,
        );
        scores.assignAll(bundle['topScores'] as List<Map<String, dynamic>>);
        userScoreDoc.value = bundle['userScoreDoc'] as Map<String, dynamic>?;
        userGlobalRank.value = bundle['userRank'] as int;
        totalRankedUsers.value = bundle['totalRanked'] as int;
      } else {
        final List<Map<String, dynamic>> top =
            await _firestoreService.getTopScores(limit: 50);
        scores.assignAll(top);
        totalRankedUsers.value = top.length;
        userScoreDoc.value = null;
        userGlobalRank.value = 0;
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
