import 'package:diabetes_tracker/mixin/common_mixin.dart';
import 'package:diabetes_tracker/utils/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/diabetes.dart';
import '../widgets/drop_down.dart';
import '../widgets/text_field.dart';

class AddReading extends StatefulWidget {
  const AddReading({Key? key}) : super(key: key);

  @override
  State<AddReading> createState() => _AddReadingState();
}

class _AddReadingState extends State<AddReading> with CommonMixin {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var autoValidate = false;

  var decimalValueCtrl = TextEditingController();

  @override
  void initState() {
    Provider.of<DiabetesProvider>(context, listen: false).clearDropDown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reading'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          children: [
            Consumer<DiabetesProvider>(
                builder: (context, provider, child) {
                  return DropDown(
                    id: provider.getDropDownId,
                    items: provider.dropDownItems.map((e) => dropDownMenuItems(e['id'], e['name'])).toList(), // stockReceiveTypeList.map((e) => dropDownMenuItems(e.id, e.name)).toList()
                    callback: (id) => provider.onChangeOfDropDown(context, id),
                    label: 'Select Type', width: MediaQuery.of(context).size.width - 20,);
                }),
            Form(
              key: _formKey,
              autovalidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
              child:  Column(
                children: [
                  InputTextField(
                      ctrl: decimalValueCtrl,
                      labelText: 'Enter Value',
                      validator: decimalValueValidator,
                      inputType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          try {
                            final text = newValue.text;
                            if (text.isNotEmpty) double.parse(text);
                            return newValue;
                          } catch (e) {}
                          return oldValue;
                        })],
                      maxLength: 10),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: onTapOfSubmit,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onTapOfSubmit(){
    FocusScope.of(context).requestFocus(FocusNode());
    var diabetesProvider = Provider.of<DiabetesProvider>(context, listen: false);
    if (!_formKey.currentState!.validate()) {

      setState(() {
        autoValidate = true;
      });
      return;
    }
    else {
      if(diabetesProvider.getDropDownId == null) {
        HelperMethods.showSnackBarMessage(context, 'Meal type required');
        return;
      }
      Provider.of<DiabetesProvider>(context, listen: false).addReading(context, {
        'reading' : double.parse(decimalValueCtrl.text.trim()),
      });
    }
  }
}