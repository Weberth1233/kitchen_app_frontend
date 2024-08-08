import 'package:get/get.dart';

class TextFieldController extends GetxController {
  RxString text = ''.obs;

  void writingText(String value) {
    text.value = value;

    print(text.value);
  }
}
