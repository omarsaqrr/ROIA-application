import 'package:flutter/material.dart';
import 'package:frontend/DTO/iam_response.dart';
import 'package:frontend/screens/navigate.dart';
import 'package:frontend/screens/register_check_email.dart';
import '../constants/colors.dart';
import '../requests/iam_request.dart';
import '../widgets/button_factory.dart';
import '../widgets/divider_factory.dart';
import '../widgets/textfield_factory.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final IAMRequest webRequest = IAMRequest();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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

                        // LOGIN LABEL
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                  ),

                  //  EMAIL TEXT BOX
                  TextFieldFactory.createTextField(context, usernameController,
                      'Email/Username', Icons.person, isError),

                  // PASSWORD TEXT BOX
                  TextFieldFactory.createObscureTextField(context,
                      passwordController, 'Password', Icons.lock, isError),

                  //  FORGOT PASSWORD
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot password ?",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Reset here.",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //  CONTINUE BUTTON
                  ButtonFactory.createLabeledButton(context, "Continue",
                      () async {
                    IAMResponse? response = await webRequest.sendLoginRequest(
                        usernameController.text, passwordController.text);
                    bool isSuccess;
                    if(response != null){
                      isSuccess = true;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  Navigate(id:response.id)));
                      setState(() {
                        isError = !isSuccess;
                      });
                    }
                    if(response == null){
                      isSuccess = false;
                      setState(() {
                        isError = !isSuccess;
                      });
                    }
                  }),

                  DividerFactory.createLabeledDivider(
                      context, "or sign in with"),

                  //  GOOGLE AND FACEBOOK ICONS
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

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //  DON'T HAVE AN ACCOUNT LABEL
                        Text(
                          "Don't have an account yet ?",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegisterCheckEmailScreen()));
                          },
                          //  REGISTER NEW ONE BUTTON
                          child: Text(
                            "Register a new one.",
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
