import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:u_arewa_studio/helper/date_helper.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/items/tab/makeup/add_makeup.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/items/tab/makeup/single_makeup.dart';
import 'package:u_arewa_studio/shared/global/globals.dart';
import 'package:u_arewa_studio/shared/model/makeup_model.dart';

import '../../../../../../../core/servie_injector/si.dart';
import '../../../../../../../shared/themes/colors.dart';

class AllMakeUp extends StatefulWidget {
  const AllMakeUp({Key? key}) : super(key: key);

  @override
  _AllMakeUpState createState() => _AllMakeUpState();
}

class _AllMakeUpState extends State<AllMakeUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: FutureBuilder<dynamic>(
        future: si.makeupService.getAllMakeup(
          currentUser.role == 'client'
              ? '$baseUrl/getAllMakeupByUser?id=${currentUser.uid}'
              : '$baseUrl/getAllMakeup',
        ),
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
                  Text('Cannot get all makeup, check your internet connection'),
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
                        'No Makeup Added Yet!',
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
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    MakeupModel makeup = snapshot.data[index];
                    return ListTile(
                      onTap: () => si.routerService.nextRoute(
                        context,
                        SingleMakeup(makeup: makeup),
                      ),
                      leading: const CircleAvatar(
                        child: Icon(Icons.person_outlined),
                      ),
                      title: Text(makeup.makeupType),
                      subtitle: Text(
                        formatDateTime(
                          convertTimestampToDateTime(makeup.createdAt.seconds),
                        ),
                        style: const TextStyle(color: Colors.green),
                      ),
                      trailing: Text(makeup.numberOfFaces.toString()),
                    );
                  },
                );
        }),
      ),
      floatingActionButton: currentUser.role != 'client'
          ? FloatingActionButton(
              onPressed: () =>
                  si.routerService.nextRoute(context, const AddMakeup()),
              backgroundColor: AppColors.primaryColor,
              child: const Icon(Icons.add),
            )
          : Container(),
    );
  }
}
