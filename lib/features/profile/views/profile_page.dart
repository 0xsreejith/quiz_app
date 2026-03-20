import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/auth/controllers/auth_controller.dart';

class ProfilePage extends GetView<AuthController> {
  const ProfilePage({super.key});

  // ── Design tokens ──────────────────────────────────────────────────
  static const Color _primary = Color(0xFF3F51B5);
  static const Color _primaryLight = Color(0xFFE8EAF6);
  static const Color _textDark = Color(0xFF1A1D2E);
  static const Color _textMuted = Color(0xFF7C8495);
  static const Color _cardBg = Color(0xFFF7F8FC);
  static const Color _divider = Color(0xFFE8ECF2);
  static const Color _starColor = Color(0xFFD4B96A);
  static const Color _accentGreen = Color(0xFF4CAF50);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // ── Profile Header ─────────────────────────────
            _buildProfileHeader(),
            const SizedBox(height: 24),

            // ── Stats Row ──────────────────────────────────
            _buildStatsRow(),
            const SizedBox(height: 20),

            // ── Best Performance ───────────────────────────
            _buildBestPerformanceCard(),
            const SizedBox(height: 16),

            // ── Dominant Field ─────────────────────────────
            _buildDominantFieldCard(),
            const SizedBox(height: 24),

            // ── Account Architecture ───────────────────────
            _buildAccountArchitectureSection(),
            const SizedBox(height: 24),

            // ── Logout Button ──────────────────────────────
            _buildLogoutButton(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  //  PROFILE HEADER
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildProfileHeader() {
    return Column(
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            // Settings icon (top-right)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.settings_outlined,
                  color: _textMuted,
                  size: 22,
                ),
              ),
            ),

            // Avatar + Badge
            Center(
              child: Column(
                children: <Widget>[
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E4EB),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: _primaryLight,
                            width: 3,
                          ),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 48,
                          color: Color(0xFFB0B8C9),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: <Color>[
                                Color(0xFF3F51B5),
                                Color(0xFF5C6BC0),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.verified,
                                color: Colors.white,
                                size: 14,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'ELITE TIER',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Name
                  const Text(
                    'Julian D. Sterling',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Subtitle
                  const Text(
                    'SENIOR QUANTITATIVE ANALYST • SINCE 2023',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: _textMuted,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: <String>[
                      'MATHEMATICS',
                      'DATA SCIENCE',
                      'LOGIC',
                    ]
                        .map((String tag) => _buildTag(tag))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _divider, width: 1.2),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: _textDark,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  //  STATS ROW
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildStatsRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: <Widget>[
          _buildStatItem('QUIZZES', '142', null),
          _buildStatDivider(),
          _buildStatItem('ACCURACY', '94.2', '%'),
          _buildStatDivider(),
          _buildStatItem('STREAK', '12', 'd'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, String? suffix) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: _textMuted,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: _primary,
              ),
              children: <TextSpan>[
                TextSpan(text: value),
                if (suffix != null)
                  TextSpan(
                    text: suffix,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 48,
      color: _divider,
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  //  BEST PERFORMANCE
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildBestPerformanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'BEST PERFORMANCE',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: _textMuted,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Advanced Algorithms',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                ),
              ),
              RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '2,480 ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: _accentGreen,
                      ),
                    ),
                    TextSpan(
                      text: 'pts',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: _accentGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  //  DOMINANT FIELD
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildDominantFieldCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'DOMINANT FIELD',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: _textMuted,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Theoretical Physics',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '42 Quizzes • 96% Mastery',
                    style: TextStyle(
                      fontSize: 13,
                      color: _textMuted.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.star_outline_rounded,
                color: _starColor,
                size: 28,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  //  ACCOUNT ARCHITECTURE
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildAccountArchitectureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 14),
          child: Text(
            'ACCOUNT ARCHITECTURE',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: _textMuted,
              letterSpacing: 1.8,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: <Widget>[
              _buildSettingsTile(
                icon: Icons.shield_outlined,
                iconBgColor: const Color(0xFFE8EAF6),
                iconColor: _primary,
                title: 'Identity & Privacy',
                subtitle: 'Manage personal visibility',
              ),
              const Divider(height: 1, indent: 68, color: _divider),
              _buildSettingsTile(
                icon: Icons.notifications_outlined,
                iconBgColor: const Color(0xFFE8EAF6),
                iconColor: _primary,
                title: 'Notification Matrix',
                subtitle: 'Configure challenge alerts',
              ),
              const Divider(height: 1, indent: 68, color: _divider),
              _buildSettingsTile(
                icon: Icons.lock_outline_rounded,
                iconBgColor: const Color(0xFFE8EAF6),
                iconColor: _primary,
                title: 'Security Protocols',
                subtitle: 'Encryption and access',
              ),
              const Divider(height: 1, indent: 68, color: _divider),
              _buildSettingsTile(
                icon: Icons.analytics_outlined,
                iconBgColor: const Color(0xFFE8EAF6),
                iconColor: _primary,
                title: 'Performance Logs',
                subtitle: 'Export quiz history data',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: <Widget>[
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: _textMuted,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: _textMuted,
            size: 22,
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  //  LOGOUT BUTTON
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: controller.logout,
        icon: const Icon(Icons.logout_rounded, size: 20),
        label: const Text(
          'Sign Out',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFE53935),
          side: const BorderSide(color: Color(0xFFFFCDD2)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}