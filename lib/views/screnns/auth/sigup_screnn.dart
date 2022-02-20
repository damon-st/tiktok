import 'package:flutter/material.dart';
import 'package:tiktok/constant.dart';
import 'package:tiktok/views/screnns/auth/login_screen.dart';
import 'package:tiktok/views/widgets/text_input_field.dart';

class SigUpScreen extends StatelessWidget {
  SigUpScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: [
              Text(
                "TikTok",
                style: TextStyle(
                  fontSize: 35,
                  color: buttonColor,
                  fontFamily: "NexaBold",
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontFamily: "NexaBold",
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/pruebatikt-5a4ca.appspot.com/o/person-png-icon-29.jpg?alt=media&token=4a880c9f-88c6-4e7f-9fb8-015d7d39e028",
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    left: width / 2,
                    child: IconButton(
                      onPressed: () {
                        authController.pickImage();
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: userNameController,
                  labelText: "UserName",
                  icon: Icons.person,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: emailController,
                  labelText: "Email",
                  icon: Icons.email,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: passwordController,
                  labelText: "Password",
                  isObscure: true,
                  icon: Icons.lock,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: width - 40,
                height: 50,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      15,
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    authController.registerUser(
                        userNameController.text,
                        emailController.text,
                        passwordController.text,
                        authController.profilePhoto);
                  },
                  child: const Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "NexaBold",
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already a have a acounnt?",
                    style: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      final router = MaterialPageRoute(builder: (c) {
                        return LoginScreen();
                      });
                      Navigator.pushReplacement(context, router);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        color: buttonColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
