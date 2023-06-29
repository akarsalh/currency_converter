import 'package:currency_converter/api.dart';
import 'package:currency_converter/dropdown.dart';
import 'package:currency_converter/managments_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  ApiClient api = ApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text("currency converter"),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            margin: EdgeInsets.only(top: 100, right: 20, left: 20),
            child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: "Input value", border: InputBorder.none),
                onChanged: (value) async {
                  if (context.read<Comp>().from.isNotEmpty &&
                      context.read<Comp>().to.isNotEmpty &&
                      context.read<Comp>().to != context.read<Comp>().from) {
                    if (value.isEmpty) {
                      value = "0";
                    }

                    context.read<Comp>().setRate(await api.getRate(
                        context.read<Comp>().from, context.read<Comp>().to));

                    String re =
                        (context.read<Comp>().rate * double.parse(value))
                            .toStringAsFixed(3);
                    context.read<Comp>().setResult(re);
                  }
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              customDropDown(
                  context.read<Comp>().currencies, context.watch<Comp>().from,
                  (val) {
                context.read<Comp>().setFromVal(val);
              }),
              FloatingActionButton(
                elevation: 0,
                onPressed: () {
                  context.read<Comp>().switchCurrencies();
                },
                child: Icon(
                  Icons.swap_horiz,
                ),
              ),
              customDropDown(
                  context.read<Comp>().currencies, context.read<Comp>().to,
                  (val) {
                context.read<Comp>().setToVal(val);
              }),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Text(
                  "result :",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(context.watch<Comp>().result)
              ],
            ),
          )
        ],
      ),
    );
  }
}
