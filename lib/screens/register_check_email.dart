import 'package:flutter/material.dart';
import 'package:frontend/requests/iam_request.dart';
import 'package:frontend/screens/register_check_username.dart';
import 'package:frontend/widgets/button_factory.dart';
import 'package:frontend/widgets/divider_factory.dart';
import 'package:frontend/widgets/textfield_factory.dart';

import '../constants/colors.dart';
import 'login_screen.dart';

class RegisterCheckEmailScreen extends StatefulWidget {
  const RegisterCheckEmailScreen({Key? key}) : super(key: key);

  @override
  State<RegisterCheckEmailScreen> createState() => _RegisterCheckEmailScreen();
}

class _RegisterCheckEmailScreen extends State<RegisterCheckEmailScreen> {
  final IAMRequest webRequest = IAMRequest();
  final TextEditingController emailController = TextEditingController();
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

                  //  EMAIL TEXT BOX
                  TextFieldFactory.createTextField(
                      context, emailController, 'Email', Icons.mail, isError),

                  //  CONTINUE BUTTON
                  ButtonFactory.createLabeledButton(context, "Continue",
                          () async {
                        bool isSuccess = await webRequest.checkEmailRequest(
                            emailController.text);
                        if (isSuccess){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterCheckUsernameScreen(email: emailController.text)));
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
