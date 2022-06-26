import 'package:diabetes_tracker/mixin/common_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reading'),
      ),
      body: Column(
        children: [
          // Consumer<DropDownProvider>(
          //     builder: (context, provider, child) {
          //       return DropDown(
          //           id: provider.stockReceiveTypeId,
          //           items: provider.stockReceiveTypeList.map((e) => dropDownMenuItems(e.id, e.name)).toList(),
          //           callback: (id) => provider.onChangeOfStockReceiveType(context, _stockUsersStreamCtrl, _goDownsBasedOnTypeStreamCtrl, id),
          //           label: 'Select Type');
          //     }),
          InputTextField(
              ctrl: decimalValueCtrl,
              labelText: 'Enter Value',
              validator: decimalValueValidator,
              inputType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10),
        ],
      ),
    );
  }
}
