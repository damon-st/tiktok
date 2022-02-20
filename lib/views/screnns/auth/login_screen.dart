import 'package:flutter/material.dart';
import 'package:tiktok/constant.dart';
import 'package:tiktok/views/screnns/auth/sigup_screnn.dart';
import 'package:tiktok/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
          child: Column(
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
                "Login",
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
                    authController.loginUser(
                        emailController.text, passwordController.text);
                  },
                  child: const Center(
                    child: Text(
                      "Login",
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
                    "Don\'t have a acounnt?",
                    style: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      final route = MaterialPageRoute(builder: ((context) {
                        return SigUpScreen();
                      }));
                      Navigator.push(context, route);
                    },
                    child: Text(
                      "Register",
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
