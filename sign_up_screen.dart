import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/res/color.dart';
import 'package:social_media/res/components/input_text_field.dart';
import 'package:social_media/res/components/roundbutton.dart';
import 'package:social_media/utils/routes/route_name.dart';
import 'package:social_media/utils/utils.dart';
import 'package:social_media/view_model/signup/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final FORMKEY = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    usernameController.dispose();
    usernameFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ChangeNotifierProvider(
              create: (_) => SignupController(),
              child: Consumer<SignupController>(
                builder: (context, value, child) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text('Welcome To App',
                            style: Theme.of(context).textTheme.headline4),
                        SizedBox(height: height * 0.01),
                        Text(
                            'Enter Your Email Address\nTo Register Your Account',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle1),
                        SizedBox(height: height * 0.01),
                        Form(
                            key: FORMKEY,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.06, bottom: height * .01),
                              child: Column(
                                children: [
                                  InputTextField(
                                    focusNode: usernameFocusNode,
                                    myController: usernameController,
                                    onFileSubmittedValue: (value) {
                                      Utils.fieldFocus(context,
                                          usernameFocusNode, emailFocusNode);
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: false,
                                    hint: 'Username',
                                    onValidator: (value) {
                                      return value.isEmpty
                                          ? 'Enter Username'
                                          : null;
                                    },
                                  ),
                                  SizedBox(height: height * .01),
                                  InputTextField(
                                    focusNode: emailFocusNode,
                                    myController: emailController,
                                    onFileSubmittedValue: (value) {
                                      Utils.fieldFocus(context, emailFocusNode,
                                          passwordFocusNode);
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: false,
                                    hint: 'Email',
                                    onValidator: (value) {
                                      return value.isEmpty
                                          ? 'Enter Email'
                                          : null;
                                    },
                                  ),
                                  SizedBox(height: height * .01),
                                  InputTextField(
                                    focusNode: passwordFocusNode,
                                    myController: passwordController,
                                    onFileSubmittedValue: (value) {},
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: true,
                                    hint: 'Password',
                                    onValidator: (value) {
                                      return value.isEmpty
                                          ? 'Enter Password'
                                          : null;
                                    },
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(height: height * .03),
                        RoundButton(
                          loading: value.loading,
                          color: AppColors.primaryColor,
                          title: 'SignUp',
                          ontap: () {
                            if (FORMKEY.currentState!.validate()) {
                              value.signup(context,
                                  usernameController.text,
                                  emailController.text,
                                  passwordController.text);
                            }
                          },
                        ),
                        SizedBox(height: height * 0.03),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.loginView);
                          },
                          child: Text.rich(TextSpan(
                              text: "Already Have An Account? ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(fontSize: 15),
                              children: [
                                TextSpan(
                                  text: ' Login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                          fontSize: 15,
                                          decoration: TextDecoration.underline),
                                )
                              ])),
                        )
                      ],
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}
