// Function Go Router
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/core/constants/route_constants.dart';

void pushScreen(BuildContext context, String path, {Object? extra}) =>
    GoRouter.of(context).push(path, extra: extra);

void goScreen(BuildContext context, String path) =>
    GoRouter.of(context).go(path);

void goHome(BuildContext context) => GoRouter.of(context).go(RouteConstants.main);

void goBack(BuildContext context) => GoRouter.of(context).pop();
