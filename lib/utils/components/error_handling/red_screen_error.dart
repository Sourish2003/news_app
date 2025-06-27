import 'package:flutter/material.dart';

class ErrorWidgetClass extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const ErrorWidgetClass(this.errorDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom Error Widget Example',
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('ERROR'),
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: CustomErrorWidget(
              errorMessage: errorDetails.exceptionAsString(),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorMessage));
  }
}
