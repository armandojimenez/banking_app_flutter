import 'package:coop_cards_poc/pages/login.dart';
import 'package:coop_cards_poc/utils/consts.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Enrollment extends StatefulWidget {
  Enrollment({Key key}) : super(key: key);

  @override
  _EnrollmentState createState() => _EnrollmentState();
}

class _EnrollmentState extends State<Enrollment> {
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).tr('enrollment')),
      ),
      body: new Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepTapped: (int step) => setState(() => _currentStep = step),
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() => _currentStep += 1);
          } else if (_currentStep == 2) {
            showDialog(context);
          }
        },
        onStepCancel: _currentStep > 0
            ? () => setState(() => _currentStep -= 1)
            : () => Navigator.pop(context),
        steps: <Step>[
          new Step(
            subtitle: Text(AppLocalizations.of(context).tr('provide_personal')),
            title: new Text(AppLocalizations.of(context).tr('personal_info')),
            content: Column(
              children: <Widget>[
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: AppLocalizations.of(context).tr('name'),
                    icon: Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: AppLocalizations.of(context).tr('lastname'),
                    icon: Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: AppLocalizations.of(context).tr('ss'),
                    icon: Icon(Icons.security),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                DateTimeField(
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).tr('dob'), icon: Icon(Icons.cake)),
                  format: new DateFormat("yyyy-MM-dd"),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            isActive: _currentStep == 0,
            state: getState(myPosition: 0, currentStep: _currentStep),
          ),
          new Step(
            title: new Text(AppLocalizations.of(context).tr('account_details')),
            content: Column(
              children: <Widget>[
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: AppLocalizations.of(context).tr('account_number'),
                    icon: Icon(Icons.account_balance),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: AppLocalizations.of(context).tr('account_pin'),
                    icon: Icon(Icons.security),
                  ),
                ),
              ],
            ),
            isActive: _currentStep == 1,
            state: getState(myPosition: 1, currentStep: _currentStep),
          ),
          new Step(
            title: new Text(AppLocalizations.of(context).tr('account_credentials')),
            content: Column(
              children: <Widget>[
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: AppLocalizations.of(context).tr('username'),
                    icon: Icon(Icons.supervised_user_circle),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).tr('password'),
                    icon: Icon(Icons.security),
                  ),
                ),
              ],
            ),
            isActive: _currentStep == 2,
            state: getState(myPosition: 2, currentStep: _currentStep),
          ),
        ],
      ),
    );
  }

  void showDialog(BuildContext context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.black,
      ),
    );
    Alert(
      closeFunction: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => new Login()));
      },
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: AppLocalizations.of(context).tr('enrollment_success'),
      buttons: [
        DialogButton(
          color: Consts.mainColor,
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => new Login()));
          },
        )
      ],
    ).show();
  }
}

StepState getState({int currentStep, int myPosition}) {

  if (myPosition == currentStep) return StepState.editing;

  if (myPosition < currentStep) return StepState.complete;

  if (myPosition > currentStep) return StepState.disabled;

  return null;
}
