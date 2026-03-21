import 'package:get/get.dart';
import 'package:quiz_app/features/home/data/models/category_model.dart';

class CategoriesController extends GetxController {
  List<CategoryModel> get categories => TriviaCategories.all;
}
