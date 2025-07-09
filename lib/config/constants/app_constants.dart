import 'package:flutter/material.dart';

// Success
const SUCCESS = 200;

// Errors
const INVALID_API_RESPONSE = 400;
const NO_INTERNET = 101;
const INVALID_FORMAT = 500;
const UNKNOWN_ERROR = 600;
const UNAUTHORISED_ERROR = 401;

const FORBIDDEN_ERROR = 403;

//colors constants
Color dashColor = const Color.fromARGB(154, 123, 123, 123);
Color barBackgroundColor = const Color.fromARGB(215, 217, 217, 217);
Color startButtonColor = const Color.fromARGB(255, 18, 103, 22);
Color stopButtonColor = const Color.fromARGB(255, 138, 14, 5);
Color disableButtonColor = const Color.fromARGB(255, 206, 206, 206);
Color toastBackgroundColor = Colors.black;
Color toastTextColor = Colors.white;
Color tableRowColor = const Color.fromARGB(142, 237, 205, 255);
Color viewAllButtonColor = Colors.black;
Color giftColor = const Color.fromARGB(201, 119, 31, 31);

//font size

double toastFontSize = 16;

//shared_preferences keys
String themeKey = "CURRENT_THEME";
String access_token = "ACCESS_TOKEN";
