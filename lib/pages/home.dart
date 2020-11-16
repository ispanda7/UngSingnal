import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ungsingal/models/user_class_model.dart';
import 'package:ungsingal/models/user_model.dart';
import 'package:ungsingal/pages/my_service.dart';
import 'package:ungsingal/pages/register.dart';
import 'package:ungsingal/utility/my_constant.dart';
import 'package:ungsingal/utility/my_style.dart';
import 'package:ungsingal/utility/normal_dialog.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String user, password;
  bool statusAuthen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.5),
            radius: 1.5,
            colors: [Colors.white, Colors.orange[700]],
          ),
        ),
        child: Stack(
          children: [
            buildContent(),
            statusAuthen ? MyStyle().showProgress() : SizedBox(),
          ],
        ),
      ),
    );
  }

  Center buildContent() {
    return Center(
        child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildLogo(),
          buildText(),
          buildTextFieldUser(),
          buildTextFieldPassword(),
          buildLogin(),
          buildTextButton(),
        ],
      ),
    ));
  }

  TextButton buildTextButton() => TextButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Register(),
          ),
        ),
        child: Text('New Register'),
      );

  Container buildLogin() {
    return Container(
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          if (user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            normalDialog(context, 'มีช่องว่าง กรุณากรอกทุกช่อง คะ');
          } else {
            setState(() {
              statusAuthen = true;
              checkAuthen();
            });
          }
        },
        child: Text('Login'),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String path =
        '${MyConstant().domain}/too/getUserWhereUserUng.php?isAdd=true&User=$user';
    await Dio().get(path).then((value) {
      setState(() {
        statusAuthen = false;
        if (value.toString() == 'null') {
          normalDialog(context, 'ไม่มี $user ในฐานข้อมูลของเรา');
        } else {
          print('value = $value');
          var result = json.decode(value.data);
          print('result = $result');
          for (var map in result) {
            // model from webstie
            UserModel userModel = UserModel.fromJson(map);
            print('name = ${userModel.name}');

            //From Class Model
            UserClassModel userClassModel = UserClassModel.fromMap(map);
            print('name = ${userClassModel.name}');

            if (password == userClassModel.password) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyService(),
                  ),
                  (route) => false);
            } else {
              normalDialog(context, 'Password False ? Please Try Agains');
              
            }
          }
        }
      });
    });
  }

  Container buildTextFieldUser() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 250,
        child: TextField(
          onChanged: (value) => user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            labelText: 'User :',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Container buildTextFieldPassword() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 250,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            labelText: 'Password :',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Text buildText() => Text(
        'Ung Sinal',
        style: GoogleFonts.stalinistOne(
            textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
          color: Colors.blue[900],
        )),
      );

  Container buildLogo() {
    return Container(
      width: 120,
      child: Image.asset('images/logo.png'),
    );
  }
}
