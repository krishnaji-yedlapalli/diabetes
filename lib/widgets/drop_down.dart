import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final dynamic id;
  final List<DropdownMenuItem> items;
  final Function(dynamic) callback;
  final String label;
  final double width;
  const DropDown({Key? key, this.id, required this.items, required this.callback, required this.label,  required this.width}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.6), width: 1),
      ),
      height: 35,
      width: widget.width,
      alignment: Alignment.center,
      child: DropdownButton<dynamic>(
          underline: SizedBox(),
          isExpanded: true,
          isDense: true,
          value: widget.id,
          icon: Icon(Icons.arrow_drop_down_circle_outlined, size: 20,),
          iconDisabledColor: Colors.grey,
          iconEnabledColor: Color.fromRGBO(132, 70, 113, 1),
          disabledHint: Text('${widget.label}', style: TextStyle(fontSize: 12, fontFamily: 'Segoe UI', color: Colors.grey)),
          hint: Text('${widget.label}', style: TextStyle(fontSize: 12, fontFamily: 'Segoe UI', color: Color.fromRGBO(132, 70, 113, 1))),
          items: widget.items,
          onChanged: (_) => widget.callback(_)),
    );
  }

  DropdownMenuItem dropDownMenuItems(int id, String value) {
    return DropdownMenuItem(
      value: id,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          '$value',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}