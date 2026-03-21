import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

class LiveHeaderSection extends StatelessWidget {
  const LiveHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Badges
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.chipBgBlue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'LOBBY ACTIVE',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'LIVE SYNC',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Colors.red,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Title
        const Text(
          'Quantum Physics &\nAstrophysics',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: AppColors.textDarkest,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        // Subtitle
        Text(
          'Exploring the foundations of the universe, from subatomic particles to galactic structures.',
          style: AppTextStyles.bodySmall(color: AppColors.textMuted).copyWith(
            fontSize: 15,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 24),
        // Info Cards Row
        const Row(
          children: [
            Expanded(child: _InfoBlock(label: 'CATEGORY', value: 'Science & Tech')),
            SizedBox(width: 12),
            Expanded(child: _InfoBlock(label: 'DIFFICULTY', value: 'Advanced')),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            Expanded(child: _InfoBlock(label: 'QUESTIONS', value: '25 Units')),
            Expanded(child: SizedBox()), // Empty space for alignment matching reference
          ],
        ),
      ],
    );
  }
}

class _InfoBlock extends StatelessWidget {
  final String label;
  final String value;

  const _InfoBlock({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.textMuted,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textDarkest,
            ),
          ),
        ],
      ),
    );
  }
}
