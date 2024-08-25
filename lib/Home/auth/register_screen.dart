import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/auth/custom_text_formfield.dart';
import 'package:todo_app/Home/home_Screen.dart';
import 'package:todo_app/Provider/user_provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/dialouge_utiils.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/my_user.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register_Screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
    //todo: show loading

    if (formKey.currentState?.validate() == true) {
      DialogeUtils.showLoading(
        context: context,
        loadingLabel: "Loading...",
      );
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, //call service
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);

        await FirebaseUtils.addUserToFireStore(myUser);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);
        //todo:hide loading
        DialogeUtils.hideLoading(context);
        //todo: show message
        DialogeUtils.showMessage(
            context: context,
            content: "Register Successfully",
            title: "Success",
            posActionName: "Ok",
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo:hide loading
          DialogeUtils.hideLoading(context);
          //todo: show message
          DialogeUtils.showMessage(
              context: context, content: "The password provided is too weak.");
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          //todo:hide loading
          DialogeUtils.hideLoading(context);
          //todo: show message
          DialogeUtils.showMessage(
              context: context,
              content: "The account already exists for that email.",
              negActionName: "Cancel");
          print('The account already exists for that email.');
        }
      } catch (e) {
        //todo:hide loading
        DialogeUtils.hideLoading(context);
        //todo: show message
        DialogeUtils.showMessage(
            context: context, content: e.toString(), negActionName: "Cancel");
        print(e);
      }
    }
  }
}
