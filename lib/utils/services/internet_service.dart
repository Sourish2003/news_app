import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

import '../../config/routes/routes.dart';

class CheckInternetConnection {
  checkInternetConnection(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      if (context.mounted) {
        return showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('No Internet Connection'),
            content: const Text(
                'Please check your internet connection and try again.'),
            actions: [
              CupertinoButton(
                onPressed: () => popRoute(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      return true;
      // Perform the network request
      // ...
    }
  }
}
