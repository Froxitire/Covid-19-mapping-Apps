import 'package:covid_19/homepage_user.dart';
import 'package:covid_19/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final TapGestureRecognizer gestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const SignInPage();
          },
        ));
      };

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: LottieBuilder.asset("assest/lotties/login.json"),
            ),
            const SizedBox(height: 20),
            // StreamBuilder<User?>(
            //     stream: FirebaseAuth.instance.userChanges(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return const Homepage();
            //       } else {
            //         return const Text("SBelum sign up sekarang");
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
                  "Sign Up",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  if (FirebaseAuth.instance.currentUser == null) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
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
                }
                // if (FirebaseAuth.instance.currentUser == null) {
                //     const SnackBar(content: Text("akun belum terdaftar/ dibuat"));
                //   } else {
                //     const Homepage();
                //   }
                // },},
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
                const TextSpan(text: " jika sudah mempunyai akun"),
              ], style: const TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

void showNotification(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.amber,
    content: Text(message.toString()),
  ));
}
