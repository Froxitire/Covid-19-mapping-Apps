import 'package:covid_19/homepage.dart';
import 'package:covid_19/homepage_user.dart';
import 'package:covid_19/main.dart';
import 'package:covid_19/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    // String emailAdmin = "admin";
    // String passAdmin = "admin";

    final TapGestureRecognizer gestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const SignUpPage();
          },
        ));
      };

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: LottieBuilder.asset(
                "assest/lotties/login.json",
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            // StreamBuilder<User?>(
            //     stream: FirebaseAuth.instance.userChanges(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return const Homepage();
            //       } else {
            //         return const Text("SBelum sign in sekarang");
            //       }
            //     }),
            TextField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              icon: const Icon(
                Icons.lock_open,
                size: 26,
              ),
              label: const Text(
                "Sign In",
                style: TextStyle(fontSize: 20),
              ),
              onLongPress: () {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return const Homepage();
                    },
                  ));
                } else if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  showNotification(context, "belum lengkap diisi");
                } else {
                  showNotification(context, "data tidak valid");
                }
              },
              onPressed: () async {
                if (FirebaseAuth.instance.currentUser == null) {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                  } on FirebaseAuthException catch (e) {
                    showNotification(context, e.message.toString());
                  }
                } else {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return const HomepageUser();
                    },
                  ));
                }
                navigatorkey.currentState!.popUntil((route) => route.isFirst);
              },
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(children: [
                const TextSpan(text: "klik "),
                TextSpan(
                  text: "disini",
                  style: const TextStyle(color: Colors.blueAccent),
                  recognizer: gestureRecognizer,
                ),
                const TextSpan(text: " untuk membuat akun"),
              ], style: const TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
