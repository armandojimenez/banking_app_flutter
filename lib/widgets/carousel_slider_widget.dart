
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coop_cards_poc/models/base_model.dart';
import 'package:coop_cards_poc/utils/consts.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarouselSliderWidger extends StatefulWidget {
  const CarouselSliderWidger({Key key}) : super(key: key);

  @override
  _CarouselSliderWidgerState createState() => _CarouselSliderWidgerState();
}

class _CarouselSliderWidgerState extends State<CarouselSliderWidger> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _cards =
        Provider.of<BaseModel>(context).getCardsWidget(true);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CarouselSlider(
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          height: MediaQuery.of(context).size.height / 4,
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
            //widget?.callback();
            Provider.of<BaseModel>(context).getShuffledList();
          },
          items: _cards.asMap().map((i, value) {
                return MapEntry(i, Builder(
                  builder: (BuildContext context) {
                    return value;
                  },
                ));
              })
              .values
              .toList(),
        ),
        new DotsIndicator(
          dotsCount: _cards.length,
          position: _current.toDouble(),
          decorator: DotsDecorator(
            activeColor: Consts.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        )
      ],
    );
  }
}