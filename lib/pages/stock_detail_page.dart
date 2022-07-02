import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_market/constants.dart';
import 'package:stock_market/pages/stock_detail_parameter_page.dart';

import '../models/stock_model.dart';

class StockDetailPage extends StatelessWidget {
  const StockDetailPage({Key? key, this.criteriaData});
  
  final StockModel? criteriaData;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff1686B0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(criteriaData!.name!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18)),
              const SizedBox(height: 4),
              Text(
                criteriaData!.tag!,
                style: TextStyle(
                    color: getColor(criteriaData!.color!), fontSize: 12),
              )
            ],
          )),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: criteriaData!.criteria!.map((criteriaData) {
            return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: criteriaData.type == "variable"
                    ? Wrap(
                        children: manipulateString(criteriaData.text!).map((e) {
                        return e.contains("(")
                            ? GestureDetector(
                                child: Text(e,
                                    style: const TextStyle(
                                        color: Color(0xff0E5BB7),
                                        height: 1.2,
                                        fontSize: 16)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (ctx) =>
                                              StockDetailedParameterPage(receivedSelectedVariable: e,
                                                  criteria: criteriaData)));
                                },
                              )
                            : Text(
                                e,
                                style: const TextStyle(
                                    color: Colors.white,
                                    height: 1.2,
                                    fontSize: 18),
                              );
                      }).toList())
                    : Text(
                        criteriaData.text!,
                        style: const TextStyle(color: Colors.white,fontSize: 18),
                      ));
          }).toList()),
    );
  }

  List<int> checkIfStringContainsPriceData(String data) {
    List<int> priceIndexList = [];
    List<String> priceList = [];
    List<String> splittedString = data.split(" ");
    for (int i = 0; i < splittedString.length; i++) {
      if (splittedString[i].toLowerCase().contains("\$")) {
        priceIndexList.add(i);
        priceList.add(splittedString[i]);
      }
    }
    return priceIndexList;
  }

  List<String> manipulateString(String data) {
    List<int> priceIndexList = checkIfStringContainsPriceData(data);
    List<String> splittedString = data.split(" ");
    for (int element in priceIndexList) {
      splittedString[element] = "(${splittedString[element]})";
    }
    List<String> tempList = [];
    for (var element in splittedString) {
      tempList.add("$element ");
    }
    splittedString = tempList;
    return splittedString;
  }

}
