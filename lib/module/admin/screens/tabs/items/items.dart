import 'package:flutter/material.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/items/tab/lalle/all_lalle.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/items/tab/makeup/all_make_up.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/items/tab/turare/all_turare.dart';

import '../../../../../shared/themes/colors.dart';

class AllItems extends StatefulWidget {
  const AllItems({Key? key}) : super(key: key);

  @override
  _AllItemsState createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.bgColor,
          title: const Text(
            'Items',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: AppColors.primaryColor,
              labelColor: AppColors.primaryColor,
              tabs: [
                Tab(
                  child: Text('Make-up'),
                ),
                Tab(
                  child: Text('Lalle'),
                ),
                Tab(
                  child: Text('Turare'),
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            AllMakeUp(),
            AllLalle(),
            AllTurare(),
          ],
        ),
      ),
    );
  }
}
