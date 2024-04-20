import 'package:app/firebase/firebase_auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/Screen/sign up/components/background.dart';

import '../../../components/already_have_an_account.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import '../../../components/rounded_password_field.dart';
import '../../../constraints.dart';
import '../../Login/login_screen.dart';
import 'or_divider.dart';


class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  String emailText = "";
  String passwordText = "";

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  void signUpUser () async {
    FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
      email: emailText, 
      password: passwordText,
      context: context
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "SIGN UP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                  setState() {
                    emailText = _email.text;
                  }
                },
                textEditingController: _email,
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  setState() {
                    passwordText = _password.text;
                  }
                },
                textEditingController: _password,
              ),
              RoundedButton(
                text: "Sign up",
                press: signUpUser,
                color: kPrimaryColor,
                
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                },
              ),
              const OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(iconSrc: "assets/icons/facebook.svg",
                  press: (){},    
                  ),
                    SocalIcon(iconSrc: "assets/icons/twitter.svg",
                  press: (){},            
                  ),
                    SocalIcon(iconSrc: "assets/icons/google-plus.svg",
                  press: (){},   
                  ),  
                ],
              )
            ],
          ),
        ));
  }
}

class SocalIcon extends StatelessWidget {
  final String iconSrc;
  final Function()? press;
  const SocalIcon({
    super.key, required this.iconSrc, required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
         margin: const EdgeInsets.symmetric(horizontal: 10),


        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
