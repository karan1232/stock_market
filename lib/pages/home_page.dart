import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_market/pages/stock_detail_page.dart';

import '../api_calls/home_api_calls.dart';
import '../constants.dart';
import '../models/api_response.dart';
import '../models/stock_model.dart';
import '../widgets/dotted_divider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0, centerTitle: true, title: const Text("Stock Scanner")),
      body: Column(
        children: [
          FutureBuilder<ApiResponse<List<StockModel>>>(
              future: HomeApiCalls().getStockCriteria(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(padding: EdgeInsets.only(top: 20),
                      child: Center(child:CircularProgressIndicator(
                    color: Colors.white,
                  )));
                } else {
                  if (snapshot.data!.error!) {
                    return Center(child: Text(snapshot.data!.reasonPhrase!));
                  } else {
                    return Expanded(
                        child: ListView.builder(
                      itemCount: snapshot.data!.body!.length,
                      itemBuilder: (ctx, index) => Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (ctx) => StockDetailPage(
                                                criteriaData:
                                                    snapshot.data!.body![index],
                                              )));
                                },
                                child: CustomTile(
                                    subtitleColor:
                                        snapshot.data!.body![index].color!,
                                    title: snapshot.data!.body![index].name!,
                                    subtitle:
                                        snapshot.data!.body![index].tag!)),
                            const SizedBox(height: 10),
                            const DottedDivider(),
                          ])),
                    ));
                  }
                }
              })
        ],
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  const CustomTile(
      {Key? key, this.title, this.subtitle, this.subtitleColor = "white"})
      : super(key: key);
  final String? title;
  final String? subtitle;
  final String subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff333333))),
          const SizedBox(width: 12),
          Text(
            title!,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          )
        ]),
        const SizedBox(height: 8),
        Row(children: [
          const SizedBox(width: 14),
          Text(
            subtitle!,
            style: TextStyle(
                color: getColor(subtitleColor),
                fontSize: 12,
                fontWeight: FontWeight.w400),
            overflow: TextOverflow.ellipsis,
          )
        ])
      ],
    );
  }
}
