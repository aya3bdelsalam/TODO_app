import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/firebase_utils.dart';
import 'package:todo_app/core/services/snack_bar_service.dart';

import '../../core/settings_provider.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  bool isObscured = true;
  var formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      decoration: const BoxDecoration(
          color: Color(0xFFDFECDB),
          image: DecorationImage(
            image: AssetImage('assets/images/auth_background.png'),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            title: const Text('Create Account'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: mediaQuery.size.height * 0.2),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: userController,
                      cursorColor: theme.primaryColor,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "please enter your full name ";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text(
                          "Full Name",
                          style: theme.textTheme.displayLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        hintText: "Enter your full name",
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: theme.primaryColorLight,
                          width: 2,
                        )),
                        suffixIcon: Icon(
                          Icons.person,
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      cursorColor: theme.primaryColor,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "please enter your email ";
                        }
                        var regex = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if (!regex.hasMatch(value)) {
                          return "invalid email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text(
                          "Email",
                          style: theme.textTheme.displayLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        hintText: "Enter your email address",
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: theme.primaryColorLight,
                          width: 2,
                        )),
                        suffixIcon: Icon(
                          Icons.email,
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      cursorColor: theme.primaryColor,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "please enter your password ";
                        }
                        return null;
                      },
                      obscureText: isObscured,
                      // show password as dots
                      decoration: InputDecoration(
                        label: Text(
                          "Password",
                          style: theme.textTheme.displayLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        hintText: "Enter your Password",
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: theme.primaryColorLight,
                          width: 2,
                        )),
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isObscured = !isObscured;
                              });
                            },
                            child: Icon(
                                color: provider.isDark()
                                    ? Colors.white
                                    : Colors.black,
                                isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                      ),
                    ),
                    const SizedBox(height: 60),
                    FilledButton(
                        onPressed: () {
                          // print(emailController.text);
                          if (formKey.currentState!.validate()) {
                            FirebaseUtils.createAccount(emailController.text,
                                    passwordController.text)
                                .then((value) {
                              if (value) {
                                EasyLoading.dismiss();
                                SnackBarService.showSuccessMessage(
                                    "Account successfully Created");
                                Navigator.pop(context);
                              }
                            });
                          }
                        },
                        style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            backgroundColor: theme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Create Account",
                                style: theme.textTheme.bodyLarge
                                    ?.copyWith(color: Colors.white)),
                            const Icon(
                              Icons.arrow_forward,
                              size: 30,
                            )
                          ],
                        )),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
