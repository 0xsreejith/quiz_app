import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/live/controllers/live_controller.dart';

import '../widgets/live_header_section.dart';
import '../widgets/live_timer_card.dart';
import '../widgets/live_participants_section.dart';
import '../widgets/live_feed_section.dart';

class LivePage extends GetView<LiveController> {
  const LivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF7F9FB), // Surface background match reference
      child: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LiveHeaderSection(),
            SizedBox(height: 32),
            LiveTimerCard(),
            SizedBox(height: 32),
            LiveParticipantsSection(),
            SizedBox(height: 32),
            LiveFeedSection(),
            SizedBox(height: 48), // Bottom padding
          ],
        ),
      ),
    );
  }
}