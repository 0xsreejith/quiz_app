import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/widgets/featured_quiz_card.dart';

/// PageView-based carousel wrapping [FeaturedQuizCard] widgets with a
/// subtle scale/depth animation for the non-active cards.
class FeaturedQuizCarousel extends StatefulWidget {
  const FeaturedQuizCarousel({
    super.key,
    required this.quizzes,
    required this.onStartQuiz,
    this.onPageChanged,
  });

  /// List of quiz data maps (title, description, category, players).
  final List<Map<String, dynamic>> quizzes;

  /// Called when the user taps the Start Quiz CTA.
  final VoidCallback onStartQuiz;

  /// Called with the new page index when the carousel page changes.
  final ValueChanged<int>? onPageChanged;

  @override
  State<FeaturedQuizCarousel> createState() => _FeaturedQuizCarouselState();
}

class _FeaturedQuizCarouselState extends State<FeaturedQuizCarousel> {
  late final PageController _controller;
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.88);
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (_controller.page != null) {
      setState(() => _currentPage = _controller.page!);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSpacing.featuredCardHeight,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.quizzes.length,
        onPageChanged: widget.onPageChanged,
        itemBuilder: (context, index) {
          // Scale factor: active card = 1.0, others slightly smaller
          final double diff = (_currentPage - index).abs();
          final double scale = (1 - (diff * 0.1)).clamp(0.9, 1.0);

          return Transform.scale(
            scale: scale,
            child: FeaturedQuizCard(
              title: widget.quizzes[index]['title'] as String,
              description: widget.quizzes[index]['description'] as String,
              category: widget.quizzes[index]['category'] as String,
              players: widget.quizzes[index]['players'] as String,
              onStartQuiz: widget.onStartQuiz,
            ),
          );
        },
      ),
    );
  }
}
