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

SharedPreferences prefs;
String id = '';
int floor = 1;
String _format = 'HH:mm';
DateTime _dateTime;

@override
void initState() { 
  super.initState();
  readLocal();
}
  void readLocal() async {
     prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('FLOOR', style: kTitleTextStyle),


            ReusableCard(
              colour: kActiveCardColor,
              cardChild: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        setState(() {
                          floor--;
                        });
                      },
                      colour: kActiveCardColor,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.minus,
                        label: '',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () => null,
                      colour: kActiveCardColor,
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
                          floor++;
                        });
                      },
                      colour: kActiveCardColor,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.plus,
                        label: '',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            BottomButton(color: Colors.orangeAccent, title: 'FINISH', onPressed:()=> _handleRelease(context),),
            ],
          );
  }

  void _handleRelease(BuildContext context) {
//update release status
    Firestore.instance.collection('users').document(id).updateData(
        {'status': 'Releasing', 'parkAt': widget.nameParking}).then((data) async {
      await prefs.setString('status', 'Releasing');
      await prefs.setString('parkAt', widget.nameParking);
      
      Navigator.pushNamed(context, Home.id);
    }).catchError((err) => print(err));
  }


  void _showTimePicker() {
    DatePicker.showDatePicker(
      context,
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.parse(MAX_DATETIME),
      initialDateTime: DateTime.parse(INIT_DATETIME),
      dateFormat: _format,
      pickerMode: DateTimePickerMode.time, // show TimePicker
      pickerTheme: DateTimePickerTheme(
        title: Container(
          decoration: BoxDecoration(color: Color(0xFFEFEFEF)),
          width: double.infinity,
          height: 56.0,
          alignment: Alignment.center,
          child: Text(
            'custom Title',
            style: TextStyle(color: Colors.green, fontSize: 24.0),
          ),
        ),
        titleHeight: 56.0,
      ),
      onCancel: () {
        debugPrint('onCancel');
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