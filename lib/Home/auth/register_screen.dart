import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Home/auth/custom_text_formfield.dart';
import 'package:todo_app/app_colors.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "register_Screen";

  TextEditingController nameController = TextEditingController(text: "nadeen");
  TextEditingController emailController =
      TextEditingController(text: "nadeen@route.com");
  TextEditingController passwordController =
      TextEditingController(text: "123456");
  TextEditingController confirmPasswordController =
      TextEditingController(text: "123456");
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Account",
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
                      CustomTextFormfield(
                        label: "Username ",
                        controller: nameController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Username';
                          }
                          return null;
                        },
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
                      CustomTextFormfield(
                          label: "Confirm Password ",
                          controller: confirmPasswordController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter Confirm Password';
                            }
                            if (text.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            if (text != passwordController.text) {
                              return 'Password is not matched';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          obscureText: true),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          onPressed: () {
                            return register();
                          },
                          child: Text("Create Account",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: AppColors.whiteColor)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        print("register Successfull");
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
