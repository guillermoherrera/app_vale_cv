import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer {
  Widget listTiles() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            decoration: const BoxDecoration(
                //color: Constants.colorDefault,
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        width: 100,
                        height: 10,
                        color: Colors.black),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        width: 100,
                        height: 10,
                        color: Colors.black),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        width: 100,
                        height: 10,
                        color: Colors.black),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        width: 20,
                        height: 20,
                        color: Colors.black),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        width: 40,
                        height: 10,
                        color: Colors.black),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Wrap(
              children: [0, 1, 2].map((e) {
                return ListTile(
                    title:
                        Container(width: 70, height: 10, color: Colors.black),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            width: 70,
                            height: 10,
                            color: Colors.black),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            width: 70,
                            height: 10,
                            color: Colors.black),
                      ],
                    ),
                    leading:
                        Container(width: 20, height: 20, color: Colors.black),
                    trailing:
                        Container(width: 20, height: 20, color: Colors.black));
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget infoVale() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Table(
              children: [
                _tableRow(
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                          width: 100, height: 30, color: Colors.black),
                    ),
                    Container()),
                _tableRow(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            width: 50,
                            height: 10,
                            color: Colors.black),
                        Container(width: 70, height: 10, color: Colors.black)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            width: 50,
                            height: 10,
                            color: Colors.black),
                        Container(width: 70, height: 10, color: Colors.black)
                      ],
                    )),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Row(
                          children: [
                            Flexible(
                              child: Container(
                                  width: 170, height: 10, color: Colors.black),
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                width: 20,
                                height: 20,
                                color: Colors.black)
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              width: 20,
                              height: 30,
                              color: Colors.black)),
                    ]),
                Container(width: 70, height: 10, color: Colors.black),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 170, height: 30, color: Colors.black),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0),
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 170, height: 30, color: Colors.black),
              ],
            ),
          )
        ],
      ),
    );
  }

  TableRow _tableRow(Widget _left, Widget _right) {
    return TableRow(children: [
      Container(
        child: _left,
        padding: const EdgeInsets.all(5.0),
      ),
      Container(
        child: Align(
          child: _right,
          alignment: Alignment.centerRight,
        ),
        padding: const EdgeInsets.all(5.0),
      ),
    ]);
  }

  Widget listWrap() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            decoration: const BoxDecoration(
                //color: Constants.colorDefault,
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        width: 100,
                        height: 10,
                        color: Colors.black),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        width: 100,
                        height: 10,
                        color: Colors.black),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        width: 100,
                        height: 10,
                        color: Colors.black),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        width: 20,
                        height: 20,
                        color: Colors.black),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        width: 40,
                        height: 10,
                        color: Colors.black),
                  ],
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  width: 250,
                  height: 50,
                  color: Colors.black)),
          const Divider(),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [0, 1, 2, 3, 4].map((e) {
                return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(3),
                    //color: Constants.colorDefault,
                    alignment: Alignment.center,
                    height: 100,
                    width: 100,
                    child:
                        Container(width: 50, height: 10, color: Colors.black),
                    decoration: BoxDecoration(
                        //color: Constants.colorDefault,
                        border: Border.all(
                            //color: Constants.colorDefaultText,
                            width: 3.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0))));
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
