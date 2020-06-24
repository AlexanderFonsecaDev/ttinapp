import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:tutorinapp/screen/Login/components/background.dart';
import 'package:tutorinapp/screen//Signup/signup_screen.dart';
import 'package:tutorinapp/components/already_have_an_account_acheck.dart';
import 'package:tutorinapp/components/rounded_button.dart';
import 'package:tutorinapp/components/rounded_input_field.dart';
import 'package:tutorinapp/components/rounded_password_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorinapp/network_utils/api.dart';
import 'package:flutter_svg/svg.dart';


class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    final TextEditingController emailController = new TextEditingController();
    final TextEditingController passwordController = new TextEditingController();


    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Iniciar sesión",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              controller: emailController,
              hintText: "Correo electrónico",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              controller: passwordController,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "Iniciar sesión",
              press: () {
                /*print({
                  'email': emailController.text,
                  'password': passwordController.text
                });*/
                _login(emailController.text, passwordController.text);
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _login(email,password) async {

  var data = {
    'email': email,
    'password': password
  };

  var res = await Network().authData(data, 'login');
  var body = json.decode(res.body);
  if (body['success']) {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', json.encode(body['token']));
    localStorage.setString('user', json.encode(body['user']));
    /*Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => Home()
      ),
    );*/

    print('logueado');

  } else {
    print("FALLO");
  }

}