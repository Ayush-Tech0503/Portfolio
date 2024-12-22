// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';

import '../../Utils/Font Style/text_styles.dart';
import '../../Utils/Theme/constant_colors.dart';
import '../Custome Buttons/elevetion_button_widget.dart';


class DatePickerWidget extends StatefulWidget {
  final ValueChanged<DateTime>? onChanged;
  final minimumDateTime;

  const DatePickerWidget({Key? key, this.onChanged, this.minimumDateTime}) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DateTime _chosenDateTime;

  @override
  void initState() {
    super.initState();
    _chosenDateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    // Create midnight of today
    DateTime minimumDateTime = DateTime.now();
    minimumDateTime = widget.minimumDateTime ?? DateTime(minimumDateTime.year, minimumDateTime.month, minimumDateTime.day+2);

    return Container(
      height: 300,
      color: ConstantColor.primaryBackgroundMainColor,
      child: Column(
        children: [
          Flexible(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: minimumDateTime, // Set initial date to midnight of today
              minimumDate: minimumDateTime, // Show only today and future dates
              onDateTimeChanged: (val) {
                setState(() {
                  _chosenDateTime = val;
                });
              },
            ),
          ),
          customButton(
            textStyleButton: ConstantTextStyle.landingScreenAppbarText,
            onPressed: (){
              setState(() {
                widget.onChanged?.call(_chosenDateTime); // Pass the selected date to the callback

              });
              Navigator.of(context).pop();
            },
            text: 'Select Date',
            backgroundColor: ConstantColor.loginWithOtpButtonColor,
            borderRadius: BorderRadius.circular(8.0),
            minimumSize:  Size(screenWidth/2.0, screenHeight/25),
            elevation: 1.0,
          ),
        ],
      ),
    );
  }
}