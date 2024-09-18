import 'package:flutter/material.dart';
import 'package:frontend/requests/iam_request.dart';
import 'package:frontend/screens/register_check_password.dart';
import 'package:frontend/widgets/button_factory.dart';
import 'package:frontend/widgets/divider_factory.dart';
import 'package:frontend/widgets/textfield_factory.dart';

import '../constants/colors.dart';
import 'login_screen.dart';

class RegisterCheckUsernameScreen extends StatefulWidget {
  final String email;

  const RegisterCheckUsernameScreen({required this.email, Key? key}) : super(key: key);

  @override
  State<RegisterCheckUsernameScreen> createState() => _RegisterCheckUsernameScreen();
}

class _RegisterCheckUsernameScreen extends State<RegisterCheckUsernameScreen> {
  final IAMRequest webRequest = IAMRequest();
  final TextEditingController usernameController = TextEditingController();
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

                  //  USERNAME TEXT BOX
                  TextFieldFactory.createTextField(
                      context, usernameController, 'Username', Icons.person_pin, isError),

                  //  CONTINUE BUTTON
                  ButtonFactory.createLabeledButton(context, "Continue",
                          () async {
                        bool isSuccess = await webRequest.checkUsernameRequest(
                            usernameController.text);
                        if (isSuccess){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterCheckPasswordScreen(email: widget.email, username: usernameController.text)));
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
