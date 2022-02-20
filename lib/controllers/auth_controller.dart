import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/constant.dart';
import 'package:tiktok/models/user.dart' as model;
import 'package:tiktok/views/screnns/auth/login_screen.dart';
import 'package:tiktok/views/screnns/home_screnn.dart';

class AuthController extends GetxController {
  static AuthController i = Get.find<AuthController>();

  late Rx<File?> _pickedImage;
  late Rx<User?> _user;

  File? get profilePhoto => _pickedImage.value;

  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInicialScreen);
  }

  void _setInicialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  //register user
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //save to user to ourh auth and Firebase firestore
        UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String dowloadUrl = await _uaploatToStorage(image);
        model.User user = model.User(
            email: email,
            name: username,
            profilePhoto: dowloadUrl,
            uuid: userCredential.user!.uid);

        await firestore
            .collection("users")
            .doc(userCredential.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar("Error createt acount", "Please enter all fields");
      }
    } catch (e) {
      Get.snackbar("Error createt acount", e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        print("success");
      } else {
        Get.snackbar("Error createt acount", "Please enter all fields");
      }
    } catch (e) {
      Get.snackbar("Error createt acount", e.toString());
    }
  }

  Future<String> _uaploatToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child("profilePics")
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    return await snap.ref.getDownloadURL();
  }

  void pickImage() async {
    try {
      final pickImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickImage != null) {
        Get.snackbar("Profile Picture", "You have selected image succefuly");
        _pickedImage = Rx<File?>(File(pickImage.path));
      }
    } catch (e) {
      print(e);
    }
  }
}
