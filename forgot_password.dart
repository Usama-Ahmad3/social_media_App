import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/res/color.dart';
import 'package:social_media/view_model/forgot_password_controller/forgotPasswordController.dart';

import '../../res/components/input_text_field.dart';
import '../../res/components/roundbutton.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final FORMKEY = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ChangeNotifierProvider(
              create: (_) => ForgotPasswordController(),
              child: Consumer<ForgotPasswordController>(
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
                        Text('Enter Your Email Address\nTo Reset Your Password',
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
                                    focusNode: emailFocusNode,
                                    myController: emailController,
                                    onFileSubmittedValue: (value) {},
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: false,
                                    hint: 'Email',
                                    onValidator: (value) {
                                      return value.isEmpty
                                          ? 'Enter Email'
                                          : null;
                                    },
                                  ),
                                  SizedBox(height: height * .03),
                                  RoundButton(
                                    loading: value.loading,
                                    color: AppColors.primaryColor,
                                    title: 'Recover',
                                    ontap: () {
                                      if (FORMKEY.currentState!.validate()) {
                                        value.fogotpassword(
                                          context,
                                          emailController.text,
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ))
                      ]));
                },
              ),
            )),
      ),
    );
  }
}
