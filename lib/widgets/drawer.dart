import 'package:coop_cards_poc/pages/activate_card.dart';
import 'package:coop_cards_poc/pages/home.dart';
import 'package:coop_cards_poc/pages/login.dart';
import 'package:coop_cards_poc/pages/payments.dart';
import 'package:coop_cards_poc/pages/settings.dart';
import 'package:coop_cards_poc/utils/consts.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[200],
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(cxt: context),
            _createDrawerItem(
                icon: Icons.credit_card,
                text: AppLocalizations.of(context).tr('main_app_title'),
                context: context,
                widget: MyHomePage()),
            _createDrawerItem(
                icon: Icons.attach_money,
                text: AppLocalizations.of(context).tr('make_payment'),
                context: context,
                widget: Payment()),
            _createDrawerItem(
                icon: Icons.add,
                text: AppLocalizations.of(context).tr('activate_card'),
                context: context,
                widget: ActivateCard()),
            Divider(),
            _createDrawerItem(
                icon: Icons.settings,
                text: AppLocalizations.of(context).tr('settings'),
                context: context,
                widget: SettingsPage(
                  isLoggedIn: true,
                )),
            _createDrawerItem(
                icon: Icons.exit_to_app,
                text: AppLocalizations.of(context).tr('logout'),
                context: context,
                widget: Login()),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                  child: Image.asset(
                'assets/images/coop_logo.png',
                scale: 2,
              )),
            )
          ],
        ),
      ),
    );
  }
}

Widget _createHeader({BuildContext cxt}) {
  return Container(
    child: DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Consts.mainColor,
        ),
        child: Stack(children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close),
              color: Colors.white,
              onPressed: () => Navigator.of(cxt).pop(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //Icon(Icons.person, size: 50, color: const Color(0xffcecd9d),),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/morrito.jpg'),
                  backgroundColor: Consts.mainColor,
                  //child: Text('AJ'),
                  maxRadius: 35.0,
                  minRadius: 20.0,
                ),
                Text(
                  'armando.jimenez.dev@gmail.com',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'armandojimenez',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )
        ])),
  );
}

Widget _createDrawerItem(
    {IconData icon, String text, Widget widget, BuildContext context}) {
  return ListTile(
    title: Text(text),
    trailing: Icon(Icons.arrow_right),
    leading: Icon(icon),
    onTap: () {
      if (widget != null && context != null) {
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => widget));
      }
    },
  );
}
