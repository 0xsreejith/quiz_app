import 'package:flutter/material.dart';

/// Maps each trivia category ID to a Material icon for the UI.
/// Falls back to [Icons.quiz_outlined] for unmapped IDs.
abstract final class CategoryIcons {
  static const Map<int, IconData> _map = <int, IconData>{
    9: Icons.lightbulb_outlined,       // General Knowledge
    10: Icons.menu_book_outlined,       // Books
    11: Icons.movie_outlined,           // Film
    12: Icons.music_note_outlined,      // Music
    13: Icons.theater_comedy_outlined,  // Musicals & Theatres
    14: Icons.tv_outlined,              // Television
    15: Icons.sports_esports_outlined,  // Video Games
    16: Icons.grid_on_outlined,         // Board Games
    17: Icons.science_outlined,         // Science & Nature
    18: Icons.computer_outlined,        // Computers
    19: Icons.calculate_outlined,       // Mathematics
    20: Icons.auto_awesome_outlined,    // Mythology
    21: Icons.sports_soccer_outlined,   // Sports
    22: Icons.public_outlined,          // Geography
    23: Icons.account_balance_outlined, // History
    24: Icons.how_to_vote_outlined,     // Politics
    25: Icons.palette_outlined,         // Art
    26: Icons.star_outline_rounded,     // Celebrities
    27: Icons.pets_outlined,            // Animals
    28: Icons.directions_car_outlined,  // Vehicles
    29: Icons.chat_bubble_outline,      // Comics
    30: Icons.phone_android_outlined,   // Gadgets
    31: Icons.animation_outlined,       // Anime & Manga
    32: Icons.smart_display_outlined,   // Cartoon & Animations
  };

  static IconData forId(int categoryId) =>
      _map[categoryId] ?? Icons.quiz_outlined;
}
