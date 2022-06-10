import 'package:flutter/material.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/expense/all_expense.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/home.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/media/all_media.dart';
import 'package:u_arewa_studio/module/client/screens/tabs/profile.dart';

List<Widget> managerPages = <Widget>[
  const Dashboard(),
  const AllMedia(),
  const AllExpense(),
  const Profile(),
];
