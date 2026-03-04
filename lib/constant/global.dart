import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
BuildContext get appContext => navigatorKey.currentState!.context;
Logger logger = Logger();
