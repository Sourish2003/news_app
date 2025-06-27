
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void openHomeScreen(BuildContext context) {
  context.push('/');
}

void popRoute(BuildContext context) {
  context.pop();
}
