import 'package:coop_cards_poc/widgets/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class BaseModel with ChangeNotifier {

  List<Widget> _transactions = [
      createTransactionListTile(
          icon: Icons.fastfood,
          title: 'Burger King #23',
          subtitle: 'ID #87899',
          date: 'March 30, 2019',
          amount: '\$7.80',
          isCredit: false),
      createTransactionListTile(
          icon: Icons.shopping_cart,
          title: 'Walmart Carolina',
          subtitle: 'ID #89034',
          date: 'March 29, 2019',
          amount: '\$100.91',
          isCredit: false),
      createTransactionListTile(
          icon: Icons.card_travel,
          title: 'Jetblue Premium',
          subtitle: 'ID #84899',
          date: 'March 27, 2019',
          amount: '\$685.77',
          isCredit: true),
      createTransactionListTile(
          icon: Icons.credit_card,
          title: 'Payment #656',
          subtitle: 'ID #87899',
          date: 'March 30, 2019',
          amount: '\$1000.80',
          isCredit: true),
      createTransactionListTile(
          icon: Icons.call,
          title: 'Claro PR #99',
          subtitle: 'ID #87899',
          date: 'March 30, 2019',
          amount: '\$7.80',
          isCredit: false),
      createTransactionListTile(
          icon: Icons.fastfood,
          title: 'Autozone #01',
          subtitle: 'ID #8754349',
          date: 'March 01, 2019',
          amount: '\$45.99',
          isCredit: false),
    ];

    List<Widget> getCardsWidget(bool isExpanded) {
      return [
        CCWidget(
      accountName: 'Discover It',
      gradient: Gradients.deepSpace,
      isVisa: true,
      balance: '1,342',
      lastDigits: '5456',
      expiryDate: '07 / 22',
      isOn: true,
      isExpanded: isExpanded,
    ),
    CCWidget(
      accountName: 'Visa Classic',
      gradient: Gradients.cosmicFusion,
      isVisa: false,
      balance: '350',
      lastDigits: '7874',
      expiryDate: '01 / 19',
      isOn: false,
      isExpanded: isExpanded,
    ),
    CCWidget(
      accountName: 'Amex Bronce',
      gradient: Gradients.backToFuture,
      isVisa: true,
      balance: '3,505',
      lastDigits: '9090',
      expiryDate: '03 / 23',
      isOn: true,
      isExpanded: isExpanded,
    ),
    CCWidget(
      accountName: 'Mastercard MC',
      gradient: Gradients.blush,
      isVisa: false,
      balance: '100',
      lastDigits: '1254',
      expiryDate: '06 / 20',
      isOn: true,
      isExpanded: isExpanded,
    ),


      ];
    }

  bool _isCarouselOn = true;
  bool _wasAuthWithSecurityCode = false;

  wasAuthWithSecurityCode() => this._wasAuthWithSecurityCode;

  setAuthWithSecurityCode(bool wasAuth) {
    _wasAuthWithSecurityCode = wasAuth;
    notifyListeners();
  }

  isCarouselOn() => this._isCarouselOn;

  setCarouselOn(bool isOn) {
    _isCarouselOn = isOn;
    notifyListeners();
  }


  BaseModel();

  getTransactions() => this._transactions;

  setTransactions(List<Widget> transactions) => _transactions = transactions;

  void getShuffledList() {
    //this._transactions = _transactions.reversed.toList();
    _transactions.shuffle();
    notifyListeners();
  }

  static ListTile createTransactionListTile(
      {IconData icon,
      String title,
      String subtitle,
      String date,
      String amount,
      bool isCredit}) {
    String operator = isCredit ? '+' : '-';
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {},
      onLongPress: () {},
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              operator + ' ' + amount,
              style: TextStyle(
                  color: isCredit ? Colors.green : Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            date,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

}