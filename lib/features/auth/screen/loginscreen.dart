import 'package:demo/utils/const/space_helper.dart';
import 'package:demo/utils/const/widgets/custom_button.dart';
import 'package:demo/features/auth/controller/auth_controller.dart';
import 'package:demo/features/auth/screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/const/widgets/text_filed_widgets.dart';
import '../../../utils/routes/routes.dart';
import '../widget/auth_widget.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authControllerProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          AuthContainerWidget(size: size, title: "Login"),
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                vSpaceXl,
                TextFromFieldWidget(
                    hint: "Email",
                    showPasswordToggle: false,
                    prefixIcon: Icons.email,
                    controller: controller.emailController),
                vSpaceRegular,
                TextFromFieldWidget(
                    hint: "Password",
                    showPasswordToggle: true,
                    prefixIcon: Icons.key,
                    controller: controller.passwordController),
                vSpaceSmall,
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forget Password ?",
                          style: TextStyle(color: Colors.grey),
                        )),
                    hSpaceSmall
                  ],
                ),
                Center(
                    child: GestureDetector(
                  onTap: () {
                    controller.signInWithGoogle(context);
                  },
                  child: Container(
                    height: 60,
                    // width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: Colors.black)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          height: 25,
                        ),
                        const Text(
                          'Sign in with Google',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                )),
                vSpaceXl,
                vSpaceSmall,
                LoginButtonWidget(
                  title: "LOGIN",
                  onTap: () {
                    ref.read(authControllerProvider).login(context);
                  },
                ),
                vSpaceMin,
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Routes.push(screen: const SignupScreen());
                            controller.emailController.clear();
                            controller.passwordController.clear();
                          },
                          child: const Text("Register"))
                    ],
                  ),
                ),
              ]))
        ]),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 80); // Start from the bottom-left corner
    path.quadraticBezierTo(
        0, size.height, 80, size.height); // Curve control point and endpoint
    path.lineTo(size.width, size.height); // Bottom-right corner
    path.lineTo(size.width, 0); // Top-right corner
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
