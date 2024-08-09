import 'package:get/get.dart';

class CheckboxController extends GetxController {
  RxBool isCheck = false.obs;

  checkIsActive(bool value) {
    isCheck.value = value;
  }
}
