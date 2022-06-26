import 'package:diabetes_tracker/mixin/common_mixin.dart';
import 'package:diabetes_tracker/screens/home.dart';
import 'package:diabetes_tracker/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/authentication.dart';
import '../../widgets/text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with CommonMixin{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var autoValidate = false;

  var firstNameCtrl = TextEditingController();
  var lastNameCtrl = TextEditingController();
  var mobileNumberCtrl = TextEditingController();
  var pwdCtrl = TextEditingController();
  var ageCtrl = TextEditingController();

  Gender? _character = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode:
        autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputTextField(
                        ctrl: firstNameCtrl,
                        labelText: 'First Name',
                        validator: firstNameValidator),
                    InputTextField(
                        ctrl: lastNameCtrl,
                        labelText: 'Last Name',
                        validator: lastNameValidator),
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
                    InputTextField(
                        ctrl: ageCtrl,
                        labelText: 'Age',
                        validator: ageValidator,
                        inputType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        maxLength: 2),
                    Padding(
                      padding: const EdgeInsets.only(left : 10.0),
                      child: Text('Gender : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                    ),
                    ListTile(
                      title: const Text('Male'),
                      leading: Radio<Gender>(
                        value: Gender.male,
                        groupValue: _character,
                        onChanged: (Gender? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Female'),
                      leading: Radio<Gender>(
                        value: Gender.female,
                        groupValue: _character,
                        onChanged: (Gender? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: onClickOfRegister,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onClickOfRegister() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (!_formKey.currentState!.validate()) {
      setState(() {
        autoValidate = true;
      });
      return;
    } else {
      Provider.of<AuthenticationProvider>(context, listen:  false).onClickOfRegister(context, {
        'firstName' : firstNameCtrl.text.trim(),
        'lastName' : lastNameCtrl.text.trim(),
        'mobileNumber' : mobileNumberCtrl.text.trim(),
        'age' : ageCtrl.text.trim(),
        'gender' : _character.toString(),
        'password' : pwdCtrl.text.trim(),
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }
}

