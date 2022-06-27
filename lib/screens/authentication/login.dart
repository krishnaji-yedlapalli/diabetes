import 'package:diabetes_tracker/mixin/common_mixin.dart';
import 'package:diabetes_tracker/providers/authentication.dart';
import 'package:diabetes_tracker/screens/authentication/register.dart';
import 'package:diabetes_tracker/services/db/authentication_db_handler.dart';
import 'package:diabetes_tracker/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with CommonMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var autoValidate = false;
  var mobileNumberCtrl = TextEditingController();
  var pwdCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode:
        autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Column(
            children: [
              InputTextField(
                  ctrl: mobileNumberCtrl,
                  labelText: 'Mobile Number',
                  validator: mobileNumberValidator,
                  inputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 10),
              InputTextField(
                  ctrl: pwdCtrl,
                  labelText: 'Password',
                  validator: passwordValidator),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: onClickOfLogin,
                    child: const Text('Log in'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: onClickOfRegister,
                      child: const Text('Register'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onClickOfLogin() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (!_formKey.currentState!.validate()) {
      setState(() {
        autoValidate = true;
      });
      return;
    } else {
      Provider.of<AuthenticationProvider>(context, listen:  false).validateLogin(context, {
        'mobileNumber' : int.parse(mobileNumberCtrl.text.trim()),
        'password' : pwdCtrl.text.trim()
      });
    }
  }

  Future<void> onClickOfRegister() async {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }
}