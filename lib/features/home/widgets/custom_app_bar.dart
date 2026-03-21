import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomAppBar extends StatelessWidget {
  final String userAvatarUrl;

  const CustomAppBar({
    super.key,
    required this.userAvatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Logo and Title
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.quiz,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'QuizApp',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
          
          const Spacer(),
          
          // User Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[200],
            backgroundImage: CachedNetworkImageProvider(userAvatarUrl),
            child: userAvatarUrl.isEmpty
                ? Icon(
                    Icons.person,
                    color: Colors.grey[400],
                    size: 20,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
