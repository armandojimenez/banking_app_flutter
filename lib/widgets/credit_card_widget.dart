import 'package:coop_cards_poc/pages/card_transactions.dart';
import 'package:coop_cards_poc/utils/consts.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CCWidget extends StatefulWidget {
  final LinearGradient gradient;
  final bool isVisa;
  final String balance;
  final String lastDigits;
  final String expiryDate;
  final bool isOn;
  final bool isExpanded;
  final String accountName;

  const CCWidget(
      {Key key,
      this.gradient,
      this.isVisa,
      this.balance,
      this.lastDigits,
      this.expiryDate,
      this.isOn,
      this.isExpanded,
      this.accountName})
      : super(key: key);

  @override
  _CCWidgetState createState() => _CCWidgetState();
}

class _CCWidgetState extends State<CCWidget> {
  var isOn;

  @override
  void initState() {
    isOn = widget.isOn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => !widget.isExpanded
          ? Navigator.push(context,
              MaterialPageRoute(builder: (_) => new TransactionsPage()))
          : null,
      child: GradientCard(
          gradient: widget.gradient,
          shadowColor: Gradients.tameer.colors.last.withOpacity(0.25),
          //elevation: ,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).tr('balance'),
                            style: new TextStyle(
                                color: Colors.grey[300], fontSize: 10),
                          ),
                          Text(
                            '\$' + widget.balance,
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Switch.adaptive(
                        value: isOn,
                        onChanged: (value) async {
                          await showOnOffDialog(value, context);
                        },
                      ),
                    ],
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      widget.isExpanded
                          ? widget.isVisa
                              ? Image.asset(
                                  'assets/images/visa_logo.png',
                                  height: 20,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/mastercard.png',
                                  height: 30,
                                  fit: BoxFit.cover,
                                )
                          : Text(widget.accountName,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                      Text(
                        '**** ' + widget.lastDigits,
                        style: new TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      widget.isExpanded
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context).tr('valid'),
                                  style: new TextStyle(
                                      color: Colors.grey[300], fontSize: 10),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    widget.expiryDate,
                                    style: new TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ],
                            )
                          : Container()
                    ],
                  ),
                  flex: 1,
                )
              ],
            ),
          )),
    );
  }

  Future showOnOffDialog(bool value, BuildContext context) async {
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
    var currentAction = value ? AppLocalizations.of(context).tr('on') : AppLocalizations.of(context).tr('off');
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.warning,
      title: currentAction + "?",
      desc: AppLocalizations.of(context).tr('sure_turn') +
          currentAction +
          AppLocalizations.of(context).tr('card_ending') +
          widget.lastDigits +
          '?',
      buttons: [
        DialogButton(
          color: Consts.mainColor,
          child: Text(
            AppLocalizations.of(context).tr('yes'),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            setState(() {
              isOn = !isOn;
            });
            Navigator.pop(context);
            await Future.delayed(const Duration(milliseconds: 650));
            Alert(
              context: context,
              style: alertStyle,
              type: AlertType.success,
              title: AppLocalizations.of(context).tr('success'),
              
              buttons: [
                DialogButton(
                  color: Consts.mainColor,
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ).show();
          },
        ),
        DialogButton(
          child: Text(
            AppLocalizations.of(context).tr('cancel'),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            
            Navigator.pop(context);
          },

          color: Colors.red,
        )
      ],
    ).show();
  }
}
