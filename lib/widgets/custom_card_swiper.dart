import 'package:app_vale_cv/widgets/animator.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

import '../helpers/constants.dart';

class CardSwiper extends StatelessWidget {
  final List<Widget> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.4,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.8,
        itemHeight: size.height * 0.4,
        itemBuilder: (_, int index) {
          final movie = movies[index];

          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 240.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Constants.colorSecondary,
                boxShadow: const [
                  BoxShadow(
                    color: Constants.colorDefault,
                    offset: Offset(2.0, 5.0), //(x,y)
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Container(
                color: Constants.colorSecondary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15.0),
                        child: Text('VALE QUINCENAL',
                            style: Constants.textStyleTitleDefault)),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text('\$12,000.00',
                            style: Constants.textStyleTitleDefault)),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: const Text('DISPONIBLE',
                            style: Constants.textStyleSubTitleDefault)),
                    const Divider(color: Constants.colorDefault),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text('\$2,000.00',
                            style: Constants.textStyleSubTitleDefault)),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: const Text('LIMITE DE CRÉDITO',
                            style: Constants.textStyleSubTitleDefault)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text('\$10,000.00',
                            style: Constants.textStyleSubTitleDefault)),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: const Text('UTILIZADO',
                            style: Constants.textStyleSubTitleDefault)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
