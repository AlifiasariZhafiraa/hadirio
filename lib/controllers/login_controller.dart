import 'package:get/get.dart';
import 'package:hadirio/api/repository.dart';
import 'package:hadirio/configs/app_route.dart';
import 'package:hadirio/presentations/widgets/text_dialog.dart';
import 'package:hadirio/utils/dialog_helper.dart';
import 'package:hadirio/utils/function.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  void login({
    required String username,
    required String password,
  }) async {
    closeKeyboard();
    DialogHelper.showLoadingDialog(Get.context!);
    final response = await Repository.login(
      username: username,
      password: password,
    );
    Get.back();
    if (response.errors != null) {
      Get.dialog(
        TextDialog(text: response.errors ?? 'Errors'),
      );
    } else {
      Get.offNamed(
        AppRoute.welcome,
        arguments: response,
      );
    }
  }
}
