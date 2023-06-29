import 'package:currency_converter/api.dart';
import 'package:currency_converter/mainscreen.dart';
import 'package:currency_converter/managments_provider.dart';
import 'package:currency_converter/noConnecttionScreen.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';

class ConnectivityWidget extends StatefulWidget {
  const ConnectivityWidget({super.key});

  @override
  State<ConnectivityWidget> createState() => _ConnectivityWidgetState();
}

class _ConnectivityWidgetState extends State<ConnectivityWidget> {
  Stream<ConnectivityResult> connectivityStream =
      Connectivity().onConnectivityChanged;

  ApiClient api = ApiClient();

  List<String> list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: connectivityStream,
      builder: (context, snapshot) {
        final connectivityResult = snapshot.data;

        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          if (list.isNotEmpty) {
            context.read<Comp>().setCurrencies(list);
            return const Mainscreen();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        } else {
          return const NoConnectionScreen();
        }
      },
    );
  }

  getCurrencies() async {
    List<String> l = await api.getCurrencies();
    if (mounted) {
      setState(() {
        list = l;
      });
    }
  }
}
