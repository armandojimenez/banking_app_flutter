import 'package:coop_cards_poc/pages/home.dart';
import 'package:coop_cards_poc/widgets/drawer.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(ActivateCard());

class ActivateCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ActivateCardState();
  }
}

class ActivateCardState extends State<ActivateCard> {
  static const String EMPTY_STRING = '';

  String cardNumber = EMPTY_STRING;
  String expiryDate = EMPTY_STRING;
  String cardHolderName = EMPTY_STRING;
  String cvvCode = EMPTY_STRING;
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).tr('activate_card_title')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardBgColor: const Color(0xff15665a),
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
              ),
              CreditCardForm(
                onCreditCardModelChange: onCreditCardModelChange,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: RaisedButton(
                  color: const Color(0xff15665a),
                  child: Text(
                    AppLocalizations.of(context).tr('activate'),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () {
                    showConfirmDialog(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showConfirmDialog(BuildContext context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
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
            context, MaterialPageRoute(builder: (_) => new MyHomePage()));
      },
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: AppLocalizations.of(context).tr('activate_success'),
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => new MyHomePage()));
          },
        )
      ],
    ).show();
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
