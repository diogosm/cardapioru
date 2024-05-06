import 'package:dropdown_button3/dropdown_button3.dart';
import 'package:flutter/material.dart';

class DropMenu extends StatefulWidget {
  const DropMenu({super.key, required this.ddList, required this.upper, required this.onChanged});

  final List<String> ddList;
  final bool upper;
  final Function(String) onChanged;

  @override
  State<DropMenu> createState() => _DropMenuState();
}

class _DropMenuState extends State<DropMenu> {

  late String dropdownValue;
  late final List<String> ddList;

  @override
  void initState() {
    if(widget.upper) {
      ddList = widget.ddList.map((val) => val.toUpperCase()).toList();
    } else {
      ddList = widget.ddList;
    }
    super.initState();
    dropdownValue = ddList.first;
    widget.onChanged(dropdownValue);
  }

  final TextStyle style = const TextStyle(color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        isDense: true,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 0),
        items: ddList
            .map<DropdownMenuItem<String>>(
              (String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: style,
                ),
              ),
            )
            .toList(),
        value: dropdownValue,
        onChanged: (value) {
          setState(() {
            dropdownValue = value as String;
          });
          widget.onChanged(value!);
        },
        style: style,
        buttonDecoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black45,
            ),
          ),
        ),
        buttonHeight: 34,
        itemPadding: const EdgeInsets.only(left: 10),
        icon: Image.asset(
          "assets/imgs/dd_icon.png",
          height: 30,
        ),
      ),
    );
  }
}
