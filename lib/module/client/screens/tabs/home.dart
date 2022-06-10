import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/helper/date_helper.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/media/single_media.dart';
import 'package:u_arewa_studio/shared/model/media_model.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';
import 'package:u_arewa_studio/shared/widgets/cards/media_card.dart';
import 'package:u_arewa_studio/shared/widgets/cards/primary_card.dart';

import '../../../../shared/global/globals.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<String> photos = [
    'https://www.theknot.com/tk-media/images/1c2c929c-1c2c-4938-8e19-b8ca14b78eb0~rs_768.h',
    'https://media1.popsugar-assets.com/files/thumbor/3NyqMrqJEQJvo8tyGa58BJ_v5PA/fit-in/1024x1024/filters:format_auto-!!-:strip_icc-!!-/2019/07/19/669/n/1922398/ede5e345c8af532d_Priyanka_Chopra_Nick_Jonas_at_Komodo_Photo_Credit_WorldRedEye.com/i/Priyanka-Celebrating-Her-Birthday-Miami.jpg',
    'https://www.unicef.org/montenegro/sites/unicef.org.montenegro/files/styles/hero_desktop/public/1.%20baby.jpg?itok=KRqvK42o'
  ];
  List<Widget> homeWidgets = [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome to \nUnlock Arewa Studio',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'RedHatMono',
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Top Pictures',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: PrimaryCard(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.network(
                      photos[index],
                      width: 200,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'My Media',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.notifications_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: FutureBuilder<List<MediaModel>>(
          future: si.mediaService
              .getAllMedia('$baseUrl/getAllMediaByUser?id=${currentUser.uid}'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitThreeBounce(
                  color: AppColors.primaryColor,
                  size: 30.0,
                ),
              );
            } else if (snapshot.hasError) {
              Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  '😕Ops!Check your internet Connection!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'RedHatMono',
                  ),
                ),
              );
            }
            List<MediaModel>? medias = snapshot.data;
            if (medias == null) {
              return const Center(
                child: Text(
                  '😕Ops!Check your internet Connection!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'RedHatMono',
                  ),
                ),
              );
            } else {
              if (medias.isEmpty) {
                homeWidgets.add(
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/svg/search.svg', width: 180),
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
                  ),
                );
              } else {
                for (MediaModel media in medias) {
                  medias.length <= 6
                      ? homeWidgets.add(
                          GestureDetector(
                            onTap: () => si.routerService.nextRoute(
                              context,
                              SingleMedia(media: media),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 7.5),
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
                          ),
                        )
                      : homeWidgets;
                }
              }
            }
            return ListView(children: homeWidgets);
          },
        ),
      ),
    );
  }
}
