import 'package:get/get.dart';

import '../../Modals/Home/user_model.dart';

class UserController extends GetxController {
  Rx<User?> currentUser = Rx<User?>(null);

  void setUser(User user) {
    currentUser.value = user;
  }

  void clearUser() {
    currentUser.value = null;
  }
}
