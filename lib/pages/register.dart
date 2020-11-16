import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungsingal/utility/my_constant.dart';
import 'package:ungsingal/utility/my_style.dart';
import 'package:ungsingal/utility/normal_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name, user, password;
  bool statusProgress = false;

  Container buildTextFieldName() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 250,
        child: TextField(
          onChanged: (value) => name = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.face),
            labelText: 'Name :',
            border: OutlineInputBorder(),
          ),
        ),
      );

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
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            labelText: 'Password :',
            border: OutlineInputBorder(),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildTextFieldName(),
                  buildTextFieldUser(),
                  buildTextFieldPassword(),
                  buildUpload()
                ],
              ),
            ),
          ),
          statusProgress ? MyStyle().showProgress() : SizedBox()
        ],
      ),
    );
  }

  Container buildUpload() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: ElevatedButton.icon(
          onPressed: () {
            print('name = $name, user = $user, password = $password');
            if (name == null ||
                name.isEmpty ||
                user == null ||
                user.isEmpty ||
                password == null ||
                password.isEmpty) {
              // Have Space
              normalDialog(context, 'Have Space ? Please Fill Every Blank');
            } else {
              // No Space
              setState(() {
                statusProgress = true;
                cheackUser(user);
              });
            }
          },
          icon: Icon(Icons.cloud_upload),
          label: Text('Upload To Server')),
    );
  }

  Future<Null> cheackUser(String user) async {
    String urlAPI =
        '${MyConstant().domain}/too/getUserWhereUserUng.php?isAdd=true&User=$user';

    print('urlAPI = $urlAPI');

    await Dio().get(urlAPI).then((value) {
      print('value = $value');

      if (value.toString() == 'null') {
        insertUser();
      } else {
        setState(() {
          statusProgress = false;
          normalDialog(context, '$user มีคนอืนใช้ไปแล้ว กรุณาเปลี่ยนใหม่่');
        });
      }
    });
  }

  Future<Null> insertUser() async {
    String path =
        '${MyConstant().domain}/too/addUserUng.php?isAdd=true&Name=$name&User=$user&Password=$password';

    print('path = $path');

    await Dio().get(path).then((value) {
      setState(() {
        statusProgress = false;
        if (value.toString() == 'true') {
          Navigator.pop(context);
        } else {
          normalDialog(context, 'Connected Loss ? Please Try Again');
        }
      });
    });
  }
}
