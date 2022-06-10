import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/items/tab/lalle/add_lalle.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/items/tab/turare/single_turare.dart';
import 'package:u_arewa_studio/shared/global/globals.dart';
import 'package:u_arewa_studio/shared/model/item_model.dart';

import '../../../../../../../core/servie_injector/si.dart';
import '../../../../../../../helper/date_helper.dart';
import '../../../../../../../shared/themes/colors.dart';

class AllTurare extends StatefulWidget {
  const AllTurare({Key? key}) : super(key: key);

  @override
  _AllTurareState createState() => _AllTurareState();
}

class _AllTurareState extends State<AllTurare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: FutureBuilder<List<ItemModel>>(
        future: si.itemService.getAllItem(currentUser.role == 'client'
            ? '$baseUrl/getAllItemsByUser?item=Turare'
            : '$baseUrl/getAllItemsByType?item=Turare'),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitThreeBounce(
                color: AppColors.primaryColor,
                size: 25.0,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child:
                  Text('Cannot get all turare, check your internet connection'),
            );
          }
          return snapshot.data!.isEmpty
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svg/search.svg', width: 180),
                      const Text(
                        'No Turare Purchased Yet!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontFamily: 'RedHatMono',
                        ),
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    ItemModel item = snapshot.data![index];
                    return ListTile(
                      onTap: () => si.routerService
                          .nextRoute(context, SingleTurare(turare: item)),
                      leading: CircleAvatar(
                        child: Icon(
                          item.item == 'Lalle'
                              ? Ionicons.hand_left_outline
                              : Icons.auto_fix_normal,
                        ),
                      ),
                      title: Text(item.item),
                      subtitle: Text(
                        formatDateTime(
                          convertTimestampToDateTime(item.createdAt.seconds),
                        ),
                        style: const TextStyle(color: Colors.green),
                      ),
                      trailing: Text(item.quantity.toString()),
                    );
                  },
                );
        }),
      ),
      floatingActionButton: currentUser.role != 'client'
          ? FloatingActionButton(
              onPressed: () => si.routerService
                  .nextRoute(context, const AddItem(item: 'Turare')),
              backgroundColor: AppColors.primaryColor,
              child: const Icon(Icons.add),
            )
          : Container(),
    );
  }
}
