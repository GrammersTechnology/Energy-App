import 'package:demo/auth/screen/loginscreen.dart';
import 'package:demo/const/space_helper.dart';
import 'package:demo/const/widgets/custom_button.dart';
import 'package:demo/controller/auth_controller.dart';
import 'package:demo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const/widgets/text_filed_widgets.dart';
import '../widget/auth_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<AuthController>(builder: (context, controller, widget) {
          return Column(children: [
            AuthContainerWidget(size: size, title: "Sign up"),
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
                  vSpaceRegular,
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        border: Border.all(color: Colors.grey)),
                    child: DropdownButton(
                      hint:
                          Text(controller.dropdowmValue ?? " Select From List"),
                      underline: const SizedBox(),
                      isExpanded: true,
                      items: controller.dropdwonList
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        controller.changeDropDownValue(value);
                      },
                      onTap: () {},
                    ),
                  ),
                  vSpaceXl,
                  vSpaceXl,
                  // controller.loader
                  //     ? const CircularProgressIndicator()
                  //     :
                  LoginButtonWidget(
                    title: "SIGNUP",
                    onTap: () {
                      controller.signup(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                            onPressed: () {
                              Routes.pushreplace(screen: const LoginScreen());
                              controller.emailController.clear();
                              controller.passwordController.clear();
                            },
                            child: const Text("Login"))
                      ],
                    ),
                  ),
                ]))
          ]);
        }),
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