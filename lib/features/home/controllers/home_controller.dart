import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/services/auth_service.dart';
import 'package:quiz_app/core/services/firestore_service.dart';
import 'package:quiz_app/features/app_shell/controllers/app_shell_controller.dart';
import 'package:quiz_app/features/home/data/models/category_model.dart';
import 'package:quiz_app/features/home/data/models/home_models.dart';
import 'package:quiz_app/routes/app_routes.dart';

class HomeController extends FullLifeCycleController with FullLifeCycleMixin {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final AuthService _authService = Get.find<AuthService>();

  final RxList<TopPerformer> topPerformers = <TopPerformer>[].obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  final RxInt userBestScore = 0.obs;
  final RxInt userTotalPlayed = 0.obs;
  final RxInt userAvgAccuracy = 0.obs;
  final RxString userGlobalBadge = 'unranked'.obs;

  DateTime? _lastLoadTime;

  /// Invalidates in-flight loads so a post-quiz refresh cannot be overwritten
  /// by a slower initial `loadData()` from cache.
  int _loadGen = 0;

  List<CategoryModel> get filteredCategories {
    final String query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return TriviaCategories.all;
    return TriviaCategories.all
        .where((CategoryModel c) => c.name.toLowerCase().contains(query))
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    final int gen = ++_loadGen;
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await Future.wait(<Future<void>>[
        _loadTopPerformers(forceServer: false, gen: gen),
        _loadUserStats(forceServer: false, gen: gen),
      ]);
      if (gen != _loadGen) return;
    } on FirebaseException catch (error) {
      if (gen == _loadGen) {
        errorMessage.value = _buildErrorMessage(error);
      }
    } catch (_) {
      if (gen == _loadGen) {
        errorMessage.value = 'Unable to load home data right now.';
      }
    } finally {
      isLoading.value = false;
      if (gen == _loadGen) {
        _lastLoadTime = DateTime.now();
      }
    }
  }

  @override
  void onResumed() {
    final DateTime now = DateTime.now();
    if (_lastLoadTime == null ||
        now.difference(_lastLoadTime!) > const Duration(minutes: 5)) {
      final int gen = ++_loadGen;
      _loadUserStats(forceServer: false, gen: gen).catchError((_) {});
      _loadTopPerformers(forceServer: false, gen: gen).catchError((_) {});
    }
  }

  Future<void> refreshAfterQuiz() async {
    final int gen = ++_loadGen;
    await Future.wait<void>(<Future<void>>[
      _loadUserStats(forceServer: true, gen: gen),
      _loadTopPerformers(forceServer: true, gen: gen),
    ]);
    if (gen != _loadGen) return;
    _lastLoadTime = DateTime.now();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onHidden() {}

  Future<void> _loadTopPerformers({
    bool forceServer = false,
    required int gen,
  }) async {
    final List<Map<String, dynamic>> result = await _firestoreService
        .getTopScores(limit: 3, forceServer: forceServer);
    if (gen != _loadGen) return;
    final String uid = _authService.currentUser?.uid ?? '';
    topPerformers.value = result.asMap().entries.map((
      MapEntry<int, Map<String, dynamic>> entry,
    ) {
      final int i = entry.key;
      final Map<String, dynamic> s = entry.value;
      final String email = s['email'] as String? ?? '';
      final String? displayName = s['displayName'] as String?;
      return TopPerformer(
        id: s['uid'] as String? ?? '$i',
        name: displayName != null && displayName.trim().isNotEmpty
            ? displayName.trim()
            : email.split('@').first,
        level: 1,
        title: i == 0
            ? 'Top Scorer'
            : i == 1
            ? 'Runner Up'
            : 'Top 3',
        points: s['totalScore'] as int? ?? 0,
        avatarUrl: '',
        badge: i == 0
            ? '🏆'
            : i == 1
            ? '🥈'
            : '🥉',
        isCurrentUser: s['uid'] == uid,
      );
    }).toList();
  }

  Future<void> _loadUserStats({bool forceServer = false, required int gen}) async {
    final String? uid = _authService.currentUser?.uid;
    if (uid == null) return;
    final Map<String, dynamic> stats = await _firestoreService.getUserStats(
      uid,
      forceServer: forceServer,
    );
    if (gen != _loadGen) return;
    userBestScore.value = (stats['totalScore'] as num?)?.toInt() ?? 0;
    userTotalPlayed.value = (stats['totalPlayed'] as num?)?.toInt() ?? 0;
    userAvgAccuracy.value = (stats['avgAccuracy'] as num?)?.round() ?? 0;
    userGlobalBadge.value = stats['globalBadge'] as String? ?? 'unranked';
  }

  void navigateToProfile(String userId) {
    final String? currentUserId = _authService.currentUser?.uid;
    if (currentUserId == null || userId != currentUserId) {
      return;
    }

    if (Get.isRegistered<AppShellController>()) {
      Get.find<AppShellController>().changeTab(4);
    }
  }

  void navigateToLeaderboard() {
    if (Get.isRegistered<AppShellController>()) {
      Get.find<AppShellController>().changeTab(2);
    }
  }

  void navigateToCategory(CategoryModel category) {
    Get.toNamed(
      AppRoutes.quiz,
      arguments: <String, dynamic>{
        'categoryId': category.id,
        'categoryName': category.name,
        'categoryEmoji': category.emoji,
      },
    );
  }

  void navigateToCategories() {
    Get.toNamed(AppRoutes.categories);
  }

  String _buildErrorMessage(FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return 'Home data is unavailable for this account right now.';
      case 'unavailable':
        return 'The service is temporarily unavailable. Try again shortly.';
      default:
        return 'Unable to load home data right now.';
    }
  }
}
