class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    required this.emoji,
  });

  final int id;
  final String name;
  final String emoji;
}

class TriviaCategories {
  static const List<CategoryModel> all = [
    CategoryModel(id: 9, name: 'General Knowledge', emoji: '🧠'),
    CategoryModel(id: 10, name: 'Books', emoji: '📚'),
    CategoryModel(id: 11, name: 'Film', emoji: '🎬'),
    CategoryModel(id: 12, name: 'Music', emoji: '🎵'),
    CategoryModel(id: 13, name: 'Musicals & Theatres', emoji: '🎭'),
    CategoryModel(id: 14, name: 'Television', emoji: '📺'),
    CategoryModel(id: 15, name: 'Video Games', emoji: '🎮'),
    CategoryModel(id: 16, name: 'Board Games', emoji: '♟️'),
    CategoryModel(id: 17, name: 'Science & Nature', emoji: '🔬'),
    CategoryModel(id: 18, name: 'Computers', emoji: '💻'),
    CategoryModel(id: 19, name: 'Mathematics', emoji: '➗'),
    CategoryModel(id: 20, name: 'Mythology', emoji: '⚡'),
    CategoryModel(id: 21, name: 'Sports', emoji: '⚽'),
    CategoryModel(id: 22, name: 'Geography', emoji: '🌍'),
    CategoryModel(id: 23, name: 'History', emoji: '🏛️'),
    CategoryModel(id: 24, name: 'Politics', emoji: '🗳️'),
    CategoryModel(id: 25, name: 'Art', emoji: '🎨'),
    CategoryModel(id: 26, name: 'Celebrities', emoji: '⭐'),
    CategoryModel(id: 27, name: 'Animals', emoji: '🐾'),
    CategoryModel(id: 28, name: 'Vehicles', emoji: '🚗'),
    CategoryModel(id: 29, name: 'Comics', emoji: '💬'),
    CategoryModel(id: 30, name: 'Gadgets', emoji: '📱'),
    CategoryModel(id: 31, name: 'Anime & Manga', emoji: '🎌'),
    CategoryModel(id: 32, name: 'Cartoon & Animations', emoji: '🐭'),
  ];
}