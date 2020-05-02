import 'package:coop_cards_poc/models/base_model.dart';
import 'package:coop_cards_poc/pages/login.dart';
import 'package:coop_cards_poc/widgets/drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  final bool isLoggedIn;
  SettingsPage({Key key, this.isLoggedIn}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String currentHomeMode = 'Carousel';
  bool _hasEmail = false;
  bool _hasPush = false;
  bool _hasSMS = false;

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    var currentLanguage = Localizations.localeOf(context).languageCode == "en"
        ? "English"
        : "Español";

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).tr('settings')),
        ),
        drawer: widget.isLoggedIn ? AppDrawer() : null,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(8),
            children: <Widget>[
              ExpansionTile(
                leading: Icon(Icons.notification_important),
                title: Text(AppLocalizations.of(context).tr('alerts')),
                children: <Widget>[
                  // ListTile(title: Text('Title of the item')),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Column(
                      children: <Widget>[
                        // ListTile(
                        //   leading: Icon(Icons.call),
                        //   title: Text('1-800-564-7687'),
                        // ),
                        CheckboxListTile(
                          //leading: Icon(Icons.email),
                          value: _hasEmail,
                          secondary: Icon(Icons.alternate_email),
                          title: Text('Email'),
                          onChanged: (bool value) =>
                              setState(() => _hasEmail = value),
                          //trailing: Icon(Icons.ac_unit),
                          // trailing: FormBuilderCheckbox(
                          //   initialValue: false,
                          // ),
                        ),
                        CheckboxListTile(
                          //leading: Icon(Icons.email),
                          value: _hasSMS,
                          secondary: Icon(Icons.sms),
                          title: Text('SMS'),
                          onChanged: (bool value) =>
                              setState(() => _hasSMS = value),
                          //trailing: Icon(Icons.ac_unit),
                          // trailing: FormBuilderCheckbox(
                          //   initialValue: false,
                          // ),
                        ),
                        CheckboxListTile(
                          //leading: Icon(Icons.email),
                          value: _hasPush,
                          secondary: Icon(Icons.notifications_active),
                          title: Text(AppLocalizations.of(context).tr('push')),
                          onChanged: (bool value) =>
                              setState(() => _hasPush = value),
                          //trailing: Icon(Icons.ac_unit),
                          // trailing: FormBuilderCheckbox(
                          //   initialValue: false,
                          // ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              ListTile(
                title: Text(AppLocalizations.of(context).tr('language')),
                // subtitle: Text('Enable Push Notifications Alerts'),
                leading: Icon(Icons.language),
                trailing: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButton<String>(
                    underline: Container(),
                    value: currentLanguage,
                    items: <String>[
                      'Español',
                      'English',
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: new Text(
                            value,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        currentLanguage = value;
                        if (value == 'English')
                          data.changeLocale(Locale("en", "US"));
                        else
                          data.changeLocale(Locale("es", "US"));
                      });
                    },
                  ),
                ),
                //trailing: Icon(icon),
              ),
              Divider(),
              SwitchListTile.adaptive(
                title: Text(AppLocalizations.of(context).tr('carousel_mode')),
                secondary: Icon(Icons.view_carousel),
                value: Provider.of<BaseModel>(context).isCarouselOn(),
                onChanged: (value) {
                  Provider.of<BaseModel>(context).setCarouselOn(value);
                },
                //leading: Icon(Icons.view_carousel),
              ),
              Divider(),
              ExpansionTile(
                leading: Icon(Icons.contact_phone),
                title: Text(AppLocalizations.of(context).tr('contact_us')),
                children: <Widget>[
                  // ListTile(title: Text('Title of the item')),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.call),
                          title: Text('1-800-564-7687'),
                        ),
                        ListTile(
                          leading: Icon(Icons.email),
                          title: Text('cooperativa@evertecinc.com'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              ListTile(
                title: Text(AppLocalizations.of(context).tr('logout')),
                leading: Icon(Icons.exit_to_app),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => Login()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
