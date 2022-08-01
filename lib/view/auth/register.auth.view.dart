import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:groupchatapp/helper/helper_functions.helper.dart';
import 'package:groupchatapp/services/auth_service.services.dart';
import 'package:groupchatapp/shared/styles.shared.dart';
import 'package:groupchatapp/view/auth/login_view.view.dart';
import 'package:groupchatapp/view/home.view.dart';
import 'package:groupchatapp/widgets/widgets.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";

  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Chat App", style: headingText),
                      const SizedBox(height: 10),
                      const Text(
                          "Create your account now to chat and explore  ",
                          style: lightText),
                      Image.asset(
                        "assets/chat.png",
                        height: 270,
                        width: double.maxFinite,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            labelText: "Full Name",
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Theme.of(context).primaryColor,
                            )),
                        onChanged: (newValue) {
                          setState(() {
                            fullName = newValue;
                            if (kDebugMode) {
                              print(fullName);
                            }
                          });
                        },
                        //check the validator

                        validator: (newVal) {
                          if (newVal!.isNotEmpty) {
                            return null;
                          } else {
                            return "Name cannot empty !";
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            labelText: "Email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Theme.of(context).primaryColor,
                            )),
                        onChanged: (newValue) {
                          setState(() {
                            email = newValue;
                            if (kDebugMode) {
                              print(email);
                            }
                          });
                        },
                        //check the validator

                        validator: (newVal) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(newVal!)
                              ? null
                              : "Please enter a valid email";
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                            labelText: "Password",
                            prefixIcon: Icon(
                              Icons.lock_open,
                              color: Theme.of(context).primaryColor,
                            )),
                        onChanged: (newValue) {
                          setState(() {
                            password = newValue;
                            if (kDebugMode) {
                              print(password);
                            }
                          });
                        },
                        //validator
                        validator: (newVal) {
                          if (newVal!.length < 6) {
                            return "Password must be at least 6 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.maxFinite,
                        height: 47,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () {
                            register();
                          },
                          child: Text(
                            "Register",
                            style: headingText.copyWith(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text.rich(
                        TextSpan(
                          text: "Already have an account ? ",
                          style: headingText.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w100),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Login",
                              style: headingText.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w100,
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    nextScreen(context, const LoginView()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authServices
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          //saving the user data to shared preferences
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
          // ignore: use_build_context_synchronously
          nextScreenReplacement(context, const HomeView());
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
