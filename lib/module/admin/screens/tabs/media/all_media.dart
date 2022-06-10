import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/helper/date_helper.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/media/add_media.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/media/single_media.dart';
import 'package:u_arewa_studio/shared/model/media_model.dart';
import 'package:u_arewa_studio/shared/widgets/cards/media_card.dart';

import '../../../../../../shared/themes/colors.dart';
import '../../../../../shared/global/globals.dart';

class AllMedia extends StatefulWidget {
  const AllMedia({Key? key}) : super(key: key);

  @override
  _AllMediaState createState() => _AllMediaState();
}

class _AllMediaState extends State<AllMedia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          'All Media',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: currentUser.role == 'admin' || currentUser.role == 'manager'
          ? StreamBuilder<dynamic>(
              stream: si.streamService.getDocStream('media'),
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
                    child: Text(
                      'Pls Check Your Internet Connection',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19, fontFamily: 'RedHatMono'),
                    ),
                  );
                }
                final data = snapshot.data!.docs;
                return snapshot.data!.docs.isEmpty
                    ? Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/svg/search.svg',
                                width: 180),
                            const Text(
                              'No Media Added Yet!',
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
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          MediaModel media =
                              MediaModel.fromJson(data[index].data());
                          if (media.userId == '') {
                            return const Center(
                              child: Text(
                                'Make Sure You are Connected to the Internet',
                                style: TextStyle(
                                    fontSize: 19, fontFamily: 'RedHatMono'),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 7.5),
                              child: GestureDetector(
                                onTap: () => si.routerService.nextRoute(
                                  context,
                                  SingleMedia(id: data[index].id, media: media),
                                ),
                                child: MediaCard(
                                  timestamp: convertTimestampToDateTime(
                                      media.createdAt.seconds),
                                  pictureType: media.pictureType,
                                  status: media.status,
                                  price: media.picturePrice,
                                  amountpaid: media.amountPaid,
                                  pendingBalance: media.pendingBalance,
                                  link: media.link,
                                ),
                              ),
                            );
                          }
                        },
                      );
              }),
            )
          : FutureBuilder<List<MediaModel>>(
              future: si.mediaService.getAllMedia(
                  currentUser.role == 'admin' || currentUser.role == 'manager'
                      ? '$baseUrl/getAllMedia'
                      : '$baseUrl/getAllMediaByUser?id=${currentUser.uid}'),
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
                    child: Text(
                      'Pls Check Your Internet Connection',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19, fontFamily: 'RedHatMono'),
                    ),
                  );
                }
                return snapshot.data!.isEmpty
                    ? Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/svg/search.svg',
                                width: 180),
                            const Text(
                              'No Media Added Yet!',
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
                          MediaModel media = snapshot.data![index];
                          if (media.userId == '') {
                            return const Center(
                              child: Text(
                                'Make Sure You are Connected to the Internet',
                                style: TextStyle(
                                    fontSize: 19, fontFamily: 'RedHatMono'),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 7.5),
                              child: GestureDetector(
                                onTap: () => si.routerService.nextRoute(
                                    context, SingleMedia(media: media)),
                                child: MediaCard(
                                  timestamp: convertTimestampToDateTime(
                                      media.createdAt.seconds),
                                  pictureType: media.pictureType,
                                  status: media.status,
                                  price: media.picturePrice,
                                  amountpaid: media.amountPaid,
                                  pendingBalance: media.pendingBalance,
                                  link: media.link,
                                ),
                              ),
                            );
                          }
                        },
                      );
              }),
            ),
      floatingActionButton:
          currentUser.role == 'admin' || currentUser.role == 'manager'
              ? FloatingActionButton(
                  onPressed: () =>
                      si.routerService.nextRoute(context, const AddMedia()),
                  backgroundColor: AppColors.primaryColor,
                  child: const Icon(Icons.add),
                )
              : Container(),
    );
  }
}
