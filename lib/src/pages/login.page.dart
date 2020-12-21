import 'package:componentes/src/widget/button.dart';
import 'package:componentes/src/widget/first.dart';
import 'package:componentes/src/widget/inputEmail.dart';
import 'package:componentes/src/widget/password.dart';
import 'package:componentes/src/widget/textLogin.dart';
import 'package:componentes/src/widget/verticalText.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF3E4753),
          image: new DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
            image: new NetworkImage(
              'https://image.freepik.com/foto-gratis/pila-libros-reloj-alarma-madera-fondo-azul_39665-35.jpg',
            ),
          ),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  VerticalText(),
                  TextLogin(),
                ]),
                InputEmail(),
                PasswordInput(),
                ButtonLogin(),
                FirstTime(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
