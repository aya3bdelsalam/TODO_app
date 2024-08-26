import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/page_route_names.dart';

import '../../core/firebase_utils.dart';
import '../../core/settings_provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isObscured = true;
  var formKey = GlobalKey<FormState>();
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
            title: const Text('Login'),
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
                    Text(
                      "Welcome back!",
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: provider.isDark() ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      // onSubmitted: (value){
                      //   print(value);
                      // },
                      // onChanged: (value){
                      //    print(value);
                      //
                      // },
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
                          color: theme.primaryColor,
                          width: 2,
                        )),
                        suffixIcon: Icon(Icons.email,
                            color: provider.isDark()
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                          color: theme.primaryColor,
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
                    const SizedBox(height: 20),
                    Text(
                      "Forgot Password?",
                      style: theme.textTheme.displaySmall?.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 60),
                    FilledButton(
                        onPressed: () {
                          // print(emailController.text);
                          // Navigator.pushReplacementNamed(context, PageRouteNames.layout);
                          if (formKey.currentState!.validate()) {
                            FirebaseUtils.signIn(emailController.text,
                                    passwordController.text)
                                .then((value) {
                              if (value) {
                                EasyLoading.dismiss();
                                Navigator.pushReplacementNamed(
                                    context, PageRouteNames.layout);
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
                            Text("Login",
                                style: theme.textTheme.bodyLarge
                                    ?.copyWith(color: Colors.white)),
                            const Icon(
                              Icons.arrow_forward,
                              size: 30,
                            )
                          ],
                        )),
                    const SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, PageRouteNames.registration);
                      },
                      child: Text(
                        "Or create My Account",
                        style: theme.textTheme.displaySmall?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
