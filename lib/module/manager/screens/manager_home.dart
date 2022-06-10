import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';

import '../../../core/servie_injector/si.dart';
import '../../../helper/date_helper.dart';
import '../../../shared/global/globals.dart';
import '../../../shared/model/media_model.dart';
import '../../../shared/widgets/cards/media_card.dart';
import '../../admin/screens/tabs/media/single_media.dart';

class ManagerHome extends StatefulWidget {
  const ManagerHome({Key? key}) : super(key: key);

  @override
  State<ManagerHome> createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  static String selectedOption = 'All';
  List<Widget> homeWidgets = [
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Welcome to \nUnlock Arewa Studio',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'RedHatMono',
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Ionicons.notifications_outline),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  selectedOption = 'All';
                },
                child: Text(
                  'All Media',
                  style: selectedOption == 'All'
                      ? const TextStyle(
                          fontSize: 18, color: AppColors.primaryColor)
                      : null,
                ),
              ),
              TextButton(
                onPressed: () {
                  selectedOption = 'Paid';
                },
                child: Text(
                  'Paid',
                  style: selectedOption == 'Paid'
                      ? const TextStyle(
                          fontSize: 18, color: AppColors.primaryColor)
                      : null,
                ),
              ),
              TextButton(
                onPressed: () {
                  selectedOption = 'Outstanding';
                },
                child: Text(
                  'Outstanding',
                  style: selectedOption == 'Outstanding'
                      ? const TextStyle(
                          fontSize: 18, color: AppColors.primaryColor)
                      : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
        ],
      ),
    ),
    const SizedBox(height: 15.0),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: AppColors.bgColor,
      body: FutureBuilder<List<MediaModel>>(
        future: si.mediaService.getAllMedia('$baseUrl/getAllMedia'),
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
          }
          for (MediaModel media in medias) {
            medias.length <= 5
                ? homeWidgets.add(
                    GestureDetector(
                      onTap: () => si.routerService.nextRoute(
                        context,
                        SingleMedia(media: media),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7.5, horizontal: 15.0),
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
          return ListView(children: homeWidgets);
        },
      ),
    );
  }
}
