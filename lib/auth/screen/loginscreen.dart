import 'package:demo/auth/screen/signup_screen.dart';
import 'package:demo/const/space_helper.dart';
import 'package:demo/const/widgets/custom_button.dart';
import 'package:demo/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/widgets/text_filed_widgets.dart';
import '../../routes/routes.dart';
import '../widget/auth_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<AuthController>(builder: (context, controller, widget) {
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
                  vSpaceXl,
                  vSpaceXl,
                  controller.loader
                      ? const CircularProgressIndicator()
                      : LoginButtonWidget(
                          title: "LOGIN",
                          onTap: () {
                            controller.login(context);
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
    });
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
