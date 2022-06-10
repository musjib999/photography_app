import 'package:flutter/material.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/items/items.dart';
import 'package:u_arewa_studio/module/client/screens/tabs/home.dart';
import 'package:u_arewa_studio/module/client/screens/tabs/profile.dart';

import '../../admin/screens/tabs/media/all_media.dart';

List<Widget> clientPages = <Widget>[
  const Home(),
  const AllMedia(),
  const AllItems(),
  const Profile(),
];
