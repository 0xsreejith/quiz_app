import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/live/controllers/live_controller.dart';

class LivePage extends GetView<LiveController> {
  const LivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.live_tv, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'Live Quizzes',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Join live quiz competitions with other players',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Obx(() => ElevatedButton.icon(
            onPressed: controller.toggleLive,
            icon: Icon(controller.isLive.value ? Icons.stop : Icons.play_arrow),
            label: Text(controller.isLive.value ? 'Stop Live' : 'Go Live'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          )),
        ],
      ),
    );
  }
}