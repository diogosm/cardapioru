import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class DropCalendar extends StatefulWidget {
  const DropCalendar({super.key, required this.onChanged});

  final Function(String) onChanged;

  @override
  State<DropCalendar> createState() => _DropCalendarState();
}

class _DropCalendarState extends State<DropCalendar> {
  var dropdownValue = "Selecione a Data";
  var dateList = <DateTime?>[];
  late bool open;

  static const namedWeekDay = <String>[
    'Segunda-Feira',
    'Terça-Feira',
    'Quarta-Feira',
    'Quinta-Feira',
    'Sexta-Feira',
    'Sábado',
    'Domingo',
  ];

  @override
  void initState() {
    open = false;
    dateList = [DateTime.now()];
    dropdownValue = '${dateList[0]!.day}/${dateList[0]!.month}/${dateList[0]!.year} - ${namedWeekDay[dateList[0]!.weekday - 1]}';
    widget.onChanged('${dateList[0]!.year}-${dateList[0]!.month}-${dateList[0]!.day}T00:00:00.000Z');
    super.initState();
  }

  final TextStyle style = const TextStyle(
      color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 34,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black45),
            ),
          ),
          child: GestureDetector(
            onTap: () {
              if (open) {
                setState(() {
                  open = false;
                });
              } else {
                setState(() {
                  open = true;
                });
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    dropdownValue,
                    style: style,
                  ),
                ),
                Image.asset(
                  "assets/imgs/dd_icon.png",
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        open
            ? Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2Config(),
                  value: dateList,
                  onValueChanged: (dates) {
                    dateList = dates;
                    setState(() {
                      open = false;
                      dropdownValue =
                          '${dateList[0]!.day}/${dateList[0]!.month}/${dateList[0]!.year} - ${namedWeekDay[dateList[0]!.weekday - 1]}';
                    });
                    widget.onChanged('${dateList[0]!.year}-${dateList[0]!.month}-${dateList[0]!.day}T00:00:00.000Z');
                  },
                ),
              )
            : Container(),
      ],
    );
  }
}
