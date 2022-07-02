import 'package:flutter/material.dart';

import '../models/stock_model.dart';
import '../widgets/dotted_divider.dart';

class StockDetailedParameterPage extends StatefulWidget {
  const StockDetailedParameterPage(
      {Key? key, this.criteria, this.receivedSelectedVariable})
      : super(key: key);
  final Criteria? criteria;
 final String? receivedSelectedVariable;

  @override
  State<StockDetailedParameterPage> createState() =>
      _StockDetailedParameterPageState();
}

class _StockDetailedParameterPageState
    extends State<StockDetailedParameterPage> {
  Map<String, dynamic>? paramValues;

  OutlineInputBorder textFieldBorder =
      const OutlineInputBorder(borderSide: BorderSide(color: Colors.black));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String trimmedSelectedVariable =
        trimExtraData(widget.receivedSelectedVariable!);
    paramValues = widget.criteria!.rawData![trimmedSelectedVariable];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.criteria!.text!.split(" ")[0],
                style: const TextStyle(color: Colors.white))),
        body: paramValues == null
            ? const Center(child: CircularProgressIndicator())
            : paramValues!["type"] == "value"
                ? Column(
                    children:
                        (paramValues!["values"] as List<dynamic>).map((e) {
                    return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 10),
                              const DottedDivider()
                            ]));
                  }).toList())
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Set Parameter",
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 30, left: 10, right: 10),
                          color: Colors.white,
                          child: Row(
                            children: [
                              const Text("Period"),
                              const Spacer(),
                              Expanded(
                                  child: SizedBox(
                                      height: 30,
                                      child: TextFormField(keyboardType: TextInputType.number,
                                        initialValue: (widget
                                                        .criteria!.rawData![
                                                    trimExtraData(widget
                                                        .receivedSelectedVariable!)]
                                                ["default_value"])
                                            .toString(),
                                        decoration: InputDecoration(
                                            focusedBorder: textFieldBorder,
                                            border: textFieldBorder,
                                            enabledBorder: textFieldBorder,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10)),
                                      )))
                            ],
                          ),
                        )
                      ],
                    )));
  }

  String trimExtraData(String variable) {
    List<String> splittedVariable = variable.split("");
    splittedVariable.remove("(");
    splittedVariable.remove(")");
    return splittedVariable.join().trim();
  }
}
