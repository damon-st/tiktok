import 'package:get/get.dart';
import 'package:tiktok/constant.dart';
import 'package:tiktok/models/user.dart';
import 'package:tiktok/views/screnns/profile_screnn.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchUser = Rx<List<User>>([]);
  List<User> get searchUsers => _searchUser.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void searchUser(String name) async {
    _searchUser.bindStream(firestore
        .collection("users")
        .where("name", isGreaterThanOrEqualTo: name)
        .snapshots()
        .map((query) {
      List<User> retVal = [];
      for (var item in query.docs) {
        retVal.add(User.fromSnap(item));
      }
      return retVal;
    }));
  }

  void onFieldSubmitted(String value) {
    searchUser(value);
  }

  void profileUser(String uuid) async {
    await Get.to(() => ProfileScreen(
          id: uuid,
        ));
  }
}
