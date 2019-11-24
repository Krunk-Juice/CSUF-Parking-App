import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_parking_app/components/bottom_button.dart';
import 'package:flutter_parking_app/components/constants.dart';
import 'package:flutter_parking_app/components/icon_content.dart';
import 'package:flutter_parking_app/components/reusable_card.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputParkingData extends StatefulWidget {
  static const String id = 'input_parking_data';
  InputParkingData({this.nameParking});
  final String nameParking;

  @override
  _InputParkingDataState createState() => _InputParkingDataState();
}

class _InputParkingDataState extends State<InputParkingData> {
  
  String id = '';
  int floor = 1;
  String _format = 'HH:mm';
  DateTime _dateTime;
  DateTime _dateTimeBeforeUpdate;
  String errorMsg='';

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.parse(INIT_DATETIME);
    
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
                      child: ReusableCard(
              // colour: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'TIME',
                    style: kTitleTextStyle,
                  ),
                  Text(
                    '${_dateTime.hour.toString().padLeft(2, '0')}:${_dateTime.minute.toString().padLeft(2, '0')}',
                    style: kNumberTextStyle,
                  ),
                ],
              ),
              onPress: _showTimePicker,
            ),
          ),
          Expanded(
                      child: ReusableCard(
              // colour: kActiveCardColor,
              cardChild: Column(
                children: <Widget>[
                  Text('FLOOR', style: kTitleTextStyle),
                  Expanded(
                                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ReusableCard(
                            onPress: () {
                              setState(() {
                                (floor>1)?floor--:errorMsg='Floor can not be lower than one';
                              });
                            },
                            // colour: kActiveCardColor,
                            cardChild: IconContent(
                              icon: FontAwesomeIcons.minus,
                              label: '',
                            ),
                          ),
                        ),
                        Expanded(
                          child: ReusableCard(
                            onPress: () => null,
                            // colour: kActiveCardColor,
                            cardChild: Text(
                              floor.toString(),
                              style: kNumberTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ReusableCard(
                            onPress: () {
                              setState(() {
                                (floor<6)?floor++:errorMsg='Floor can not be greater than six';
                              });
                            },
                            // colour: kActiveCardColor,
                            cardChild: IconContent(
                              icon: FontAwesomeIcons.plus,
                              label: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(errorMsg,style: kErrorTextStyle,)
                ],
              ),
            ),
          ),
          BottomButton(
            color: Colors.greenAccent,
            title: 'FINISH',
            onPressed: () => _handleRelease(context),
          ),
        ],
      ),
    );
  }

  void _handleRelease(BuildContext context) async {
    // print(_dateTime.millisecondsSinceEpoch);
//update release status
  SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    
    Firestore.instance
        .collection('users')
        .document(id)
        .updateData({'status': 'Releasing', 'parkAt': widget.nameParking,'leaveAt':_dateTime.millisecondsSinceEpoch,'floor':floor}).then(
            (data) async {
              
      await prefs.setString('status', 'Releasing');
      await prefs.setString('parkAt', widget.nameParking);
      await prefs.setInt('floor', floor);
      await prefs.setString('releaserId', '');//inportant for check swap
      await prefs.setString('leaveAt', _dateTime.millisecondsSinceEpoch.toString());

      Navigator.pushNamed(context, Home.id);
    }).catchError((err) => print(err));
  }

  void _showTimePicker() {
    setState(() {
      _dateTimeBeforeUpdate = _dateTime;
    });
    DatePicker.showDatePicker(
      context,
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.parse(MAX_DATETIME),
      initialDateTime: _dateTime,
      dateFormat: _format,
      pickerMode: DateTimePickerMode.time, // show TimePicker
      pickerTheme: DateTimePickerTheme(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ?kBottomDatePickerDarkColor:kBottomDatePickerColor,
        itemTextStyle: kDatePickerTextStyle,
        confirm:
            Text('Done', style: TextStyle(fontSize: 30.0, color: Colors.red)),
        cancel: Text('Cancel',
            style: TextStyle(fontSize: 30.0, color: Colors.cyan)),
      ),
      onCancel: () {
        setState(() {
          _dateTime = _dateTimeBeforeUpdate;
        });
      },
      onChange: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
        });
      },
    );
  }
}
