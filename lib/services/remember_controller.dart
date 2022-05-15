import 'package:ahlem/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RememberController extends GetxController {
  RememberAdmin(Cusers user) {
    var storage = GetStorage();
    token(1);
    storage.write("user", {
      'email': user.Email,
      'name': user.name,
      'phone': user.Gsm,
      'url': user.Url,
      'id': user.uid,
    });
  }

  RememberClient(Cusers user) {
    var storage = GetStorage();
    token(2);
    storage.write("user", {
      'email': user.Email,
      'name': user.name,
      'phone': user.Gsm,
      'url': user.Url,
      'id': user.uid,
    });
  }

  token(int index) {
    var storage = GetStorage();
    storage.write("auth", 1);
    storage.write("type_auth", index);
  }

  Logout() async {
    var storage = GetStorage();
    storage.write("auth", 0);
    storage.remove("user");
    /* Get.to(());*/
  }

  check() {
    var storage = GetStorage();
    storage.write("seen", 1);
  }
}
