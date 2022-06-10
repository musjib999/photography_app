import 'package:flutter/material.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/analytics/all_analytics.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/connections/all_connections.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/expense/all_expense.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/home.dart';

List<Widget> adminPages = <Widget>[
  const Dashboard(),
  const AllAnalytics(),
  const AllExpense(),
  const AllConnections(),
];
