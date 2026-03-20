import 'package:get/get.dart';

class LiveController extends GetxController {
  final RxBool isLive = false.obs;
  
  void toggleLive() {
    isLive.value = !isLive.value;
  }
}