import 'package:flutter/material.dart';
import 'package:frontend/requests/iam_request.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/widgets/button_factory.dart';
import 'package:frontend/widgets/divider_factory.dart';
import 'package:frontend/widgets/textfield_factory.dart';

import '../constants/colors.dart';

class RegisterCheckPasswordScreen extends StatefulWidget {
  final String email;
  final String username;

  const RegisterCheckPasswordScreen({required this.email, required this.username, Key? key}) : super(key: key);

  @override
  State<RegisterCheckPasswordScreen> createState() =>
      _RegisterCheckPasswordScreenState();
}

class _RegisterCheckPasswordScreenState
    extends State<RegisterCheckPasswordScreen> {
  final IAMRequest webRequest = IAMRequest();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paletteBlue,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        // SUBMARK LOGO
                        Image.asset(
                          'assets/images/logo_submark.png',
                          width: 100,
                          height: 100,
                        ),

                        // REGISTER LABEL
                        Text(
                          'Register',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                  ),

                  //  PASSWORD TEXT BOX
                  TextFieldFactory.createObscureTextField(context,
                      passwordController, 'Password', Icons.lock, isError),

                  //  CHECK PASSWORD TEXT BOX
                  TextFieldFactory.createObscureTextField(
                      context,
                      confirmPasswordController,
                      'Verify password',
                      Icons.library_add_check,
                      isError),

                  //  CONTINUE BUTTON
                  ButtonFactory.createLabeledButton(context, "Continue",
                          () async {
                        bool isSuccess = passwordController.text == confirmPasswordController.text;
                        if (isSuccess){
                          await webRequest.sendRegisterRequest(widget.email, widget.username, passwordController.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        }
                        setState(() {
                          isError = !isSuccess;
                        });
                      }),

                  //  OR SIGN UP WITH LABEL
                  DividerFactory.createLabeledDivider(
                      context, "or sign up with"),

                  // GOOGLE AND FACEBOOK ICONS ROW
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonFactory.createIconButton(
                                () {}, 'assets/images/icons/google-icon.png'),
                        ButtonFactory.createIconButton(
                                () {}, 'assets/images/icons/facebook-icon.png'),
                      ],
                    ),
                  ),

                  DividerFactory.createDivider(context),

                  //  ALREADY HAVE AN ACCOUNT LABEL
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Already have an account ?",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },

                          //  LOG IN TO EXISTING ONE BUTTON
                          child: Text(
                            "Login to an existing one.",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
