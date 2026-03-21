import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:quiz_app/features/home/data/models/home_models.dart';

class TopPerformerItem extends StatelessWidget {
  final TopPerformer performer;
  final VoidCallback onTap;

  const TopPerformerItem({
    super.key,
    required this.performer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: performer.isCurrentUser 
              ? Colors.indigo.withOpacity(0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey[200],
              backgroundImage: performer.avatarUrl.isNotEmpty
                  ? CachedNetworkImageProvider(performer.avatarUrl)
                  : null,
              child: performer.avatarUrl.isEmpty
                  ? Icon(
                      Icons.person,
                      color: Colors.grey[400],
                      size: 24,
                    )
                  : null,
            ),
            
            const SizedBox(width: 12),
            
            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        performer.displayName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: performer.isCurrentUser 
                              ? const Color(0xFF6366F1)
                              : const Color(0xFF1A1A1A),
                        ),
                      ),
                      if (performer.badge.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Text(
                          performer.badge,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Level ${performer.level} ${performer.title}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            // Points
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  performer.formattedPoints,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                if (performer.isCurrentUser)
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'On Fire 🔥',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange[700],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
