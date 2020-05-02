import 'package:coop_cards_poc/utils/consts.dart';
import 'package:coop_cards_poc/widgets/drawer.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'home.dart';

class Payment extends StatefulWidget {
  Payment({Key key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  static final List<String> _cards = [
    'Visa Classic x9978',
    'Visa Black x7578',
    'Master Card Premium x9888',
    'Discover IT x5975',
  ];

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).tr('pay_card_title')),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    initialValue: {
                      'date': DateTime.now(),
                      'accept_terms': false,
                    },
                    autovalidate: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            AppLocalizations.of(context).tr('pay_card'),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        FormBuilderDropdown(
                          attribute: "cards",

                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).tr('credit_card'),
                              border: OutlineInputBorder()),
                          // initialValue: 'Male',
                          hint: Text(AppLocalizations.of(context).tr('credit_card')),
                          validators: [FormBuilderValidators.required()],
                          items: _cards
                              .map((card) => DropdownMenuItem(
                                  value: card, child: Text("$card")))
                              .toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            AppLocalizations.of(context).tr('this_date'),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        FormBuilderDateTimePicker(
                          // initialDate: DateTime.now(),
                          attribute: "date",
                          inputType: InputType.date,
                          format: DateFormat("yyyy-MM-dd"),
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).tr('payment_date'),
                              border: OutlineInputBorder()),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            AppLocalizations.of(context).tr('this_amount'),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        FormBuilderTextField(
                          attribute: 'amount',
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context).tr('payment_amount'),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        FormBuilderCheckbox(
                          attribute: 'accept_terms',
                          decoration: InputDecoration(
                            //labelText: "Pay on this date:",
                            border: InputBorder.none,
                          ),
                          label: Text(
                              AppLocalizations.of(context).tr('payment_terms')),
                          validators: [
                            FormBuilderValidators.requiredTrue(
                              errorText:
                                  AppLocalizations.of(context).tr('payment_terms_error'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        child: Text(
                          AppLocalizations.of(context).tr('pay'),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        color: Consts.mainColor,
                        onPressed: () {
                          if (_fbKey.currentState.saveAndValidate()) {
                            print(_fbKey.currentState.value);
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
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => new MyHomePage()));
                              },
                              context: context,
                              style: alertStyle,
                              type: AlertType.success,
                              title: AppLocalizations.of(context).tr('success'),
                              desc:  AppLocalizations.of(context).tr('your_payment') + _fbKey.currentState.value['cards'] + AppLocalizations.of(context).tr('scheduled'),
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => new MyHomePage()));
                                  },
                                )
                              ],
                            ).show();
                          }
                        },
                      ),
                      RaisedButton(
                        child: Text(AppLocalizations.of(context).tr('reset'), style: TextStyle(fontSize: 20, color: Colors.white)),
                        color: Colors.grey,
                        onPressed: () {
                          _fbKey.currentState.reset();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
