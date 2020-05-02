import 'dart:ui';

import 'package:coop_cards_poc/models/base_model.dart';
import 'package:coop_cards_poc/pages/card_transactions.dart';
import 'package:coop_cards_poc/pages/login.dart';
import 'package:coop_cards_poc/utils/consts.dart';
import 'package:coop_cards_poc/widgets/carousel_slider_widget.dart';
import 'package:coop_cards_poc/widgets/drawer.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var _isCarouselOn = Provider.of<BaseModel>(context).isCarouselOn();
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(_isCarouselOn ? Icons.view_list : Icons.view_carousel),
            onPressed: () {
              Provider.of<BaseModel>(context).setCarouselOn(!_isCarouselOn);
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => showLogOutDialog(context),
          ),
        ],
        title: Text(AppLocalizations.of(context).tr('main_app_title')),
      ),
      backgroundColor: Colors.grey[200],
      body: Container(
        child: AnimatedCrossFade(
          firstChild: _getHomeCarousel(context),
          secondChild: _getHomeList(),
          duration: const Duration(seconds: 1),
          crossFadeState: _isCarouselOn
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
      ),
    );
  }

  Widget _getHomeList() {
    List<Widget> _cards = Provider.of<BaseModel>(context).getCardsWidget(false);

    return AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
          itemCount: _cards.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50,
                child: FadeInAnimation(
                  child: _cards[index],
                ),
              ),
            );
          }),
    );
  }

  void showLogOutDialog(BuildContext context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.warning,
      title: AppLocalizations.of(context).tr('logout_question'),
      desc: AppLocalizations.of(context).tr('sure_logout'),
      buttons: [
        DialogButton(
          child: Text(
            AppLocalizations.of(context).tr('yes'),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => new Login())),
          color: Consts.mainColor,
        ),
        DialogButton(
          color: Colors.red,
          child: Text(
            AppLocalizations.of(context).tr('cancel'),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ).show();
  }

  Container _getHomeCarousel(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: CarouselSliderWidger(),
          ),
          Expanded(
            flex: 5,
            child: getLatestTransactionsWidget(context),
          )
        ],
      ),
    );
  }

  Container getLatestTransactionsWidget(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 10,
                blurRadius: 5,
                offset: Offset(0, 7), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0)),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).tr('latest_transactions'),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          AppLocalizations.of(context).tr('see_all'),
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TransactionsPage())),
                    ),
                  ),
                ],
              ),
              Divider(),
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: Provider.of<BaseModel>(context)
                        .getTransactions()
                        .length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50,
                          child: FadeInAnimation(
                            child: Provider.of<BaseModel>(context)
                                .getTransactions()[index],
                          ),
                        ),
                      );
                    }),
              )
            ],
          )),
    );
  }
}
