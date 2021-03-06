import 'package:componentes/src/widget/buttonNewUser.dart';
import 'package:componentes/src/widget/newEmail.dart';
import 'package:componentes/src/widget/newName.dart';
import 'package:componentes/src/widget/password.dart';
import 'package:componentes/src/widget/singup.dart';
import 'package:componentes/src/widget/textNew.dart';
import 'package:componentes/src/widget/userOld.dart';
import 'package:flutter/material.dart';

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
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
                Row(
                  children: <Widget>[
                    SingUp(),
                    TextNew(),
                  ],
                ),
                NewNome(),
                NewEmail(),
                PasswordInput(),
                ButtonNewUser(),
                UserOld(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
