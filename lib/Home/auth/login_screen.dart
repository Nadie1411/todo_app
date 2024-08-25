import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/auth/custom_text_formfield.dart';
import 'package:todo_app/Home/auth/register_screen.dart';
import 'package:todo_app/Home/home_Screen.dart';
import 'package:todo_app/Provider/user_provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/dialouge_utiils.dart';
import 'package:todo_app/firebase_utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login_Screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController(text: "nadeen@route.com");

  TextEditingController passwordController =
      TextEditingController(text: "123456");

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.whiteColor)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Welcome Back!",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CustomTextFormfield(

                        label: "Email ",
                        controller: emailController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Email';
                          }
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(emailController.text);
                          if (!emailValid) {
                            return 'incorrect Email,please enter valid Email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      CustomTextFormfield(
                        label: "Password",
                        controller: passwordController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Password';
                          }
                          if (text.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        obscureText: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          onPressed: () {
                            return login();
                          },
                          child: Text("Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: AppColors.whiteColor)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RegisterScreen.routeName);
                          },
                          child: Text("Or create account",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: AppColors.primaryColor)),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      DialogeUtils.showLoading(context: context, loadingLabel: "Waiting...",);
      //todo: show loading
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        var user = await FirebaseUtils.readUserFromFirestore(
            credential.user?.uid ?? '');
        if (user == null) {
          print('inside if');
          return;

          // DialogeUtils.hideLoading(context);
          // return DialogeUtils.showMessage(
          //     context: context, content: 'failed', negActionName: "Cancel");
        }
        print('after if');
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        //todo:hide loading
        DialogeUtils.hideLoading(context);
        //todo: show message
        DialogeUtils.showMessage(
            context: context,
            content: "Login Successfull",
            posActionName: "Ok",
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          //todo:hide loading
          DialogeUtils.hideLoading(context);
          //todo: show message
          DialogeUtils.showMessage(
              context: context,
              content:
                  'The supplied auth credential is incorrect, malformed or has expired.',
              negActionName: "Cancel");
        }
      } catch (e) {
        //todo:hide loading
        DialogeUtils.hideLoading(context);
        //todo: show message
        DialogeUtils.showMessage(
            context: context, content: e.toString(), negActionName: "Cancel");
      }
    }
  }
}
