import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/helper/date_helper.dart';
import 'package:u_arewa_studio/helper/form_helper.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/connections/all_connections.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/items/items.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/media/all_media.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/users/client/all_client.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/users/manager/all_managers.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/users/staff/all_staff.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/users/staff/single_staff.dart';
import 'package:u_arewa_studio/shared/model/analytic_models.dart';
import 'package:u_arewa_studio/shared/model/staff_model.dart';
import 'package:u_arewa_studio/shared/widgets/cards/analytics_card.dart';
import 'package:u_arewa_studio/shared/widgets/cards/quick_access_card.dart';

import '../../../../shared/global/globals.dart';
import '../../../../shared/themes/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String selectedMonth = getTodaysDate().split(',')[0].split(' ')[0];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Welcome to \nUnlock Arewa Studio',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'RedHatMono',
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                FutureBuilder<int>(
                    future: si.analyticsService
                        .getMonthlyExpensesCost(selectedMonth),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitThreeBounce(
                            color: Colors.white,
                            size: 20,
                          ),
                        );
                      }
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton<dynamic>(
                                      iconDisabledColor: Colors.white,
                                      icon: const Icon(
                                        Icons.expand_more,
                                        color: AppColors.primaryColor,
                                      ),
                                      style: const TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 16,
                                      ),
                                      value: selectedMonth,
                                      items: getDropdownItems(months),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedMonth = value;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    formatMoney(snapshot.data ?? 0),
                                    style: const TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const LinearProgressIndicator(
                                    value: 0.7,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.primaryColor),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Monthly Expenses',
                                    style: TextStyle(
                                        color: AppColors.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            const Icon(Ionicons.stats_chart,
                                color: AppColors.primaryColor)
                          ],
                        ),
                      );
                    }),
                const SizedBox(height: 15),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          si.routerService.nextRoute(context, const AllMedia()),
                      child: Column(
                        children: const [
                          QuickAccessCard(
                            color: Colors.green,
                            icon: Ionicons.folder_outline,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Media',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => si.routerService.nextRoute(
                          context,
                          currentUser.role == 'manager'
                              ? const AllClients()
                              : const AllManagers()),
                      child: Column(
                        children: [
                          const QuickAccessCard(
                            color: Colors.red,
                            icon: Ionicons.person_outline,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currentUser.role != 'manager'
                                ? 'Manager'
                                : 'Client',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          si.routerService.nextRoute(context, const AllItems()),
                      child: Column(
                        children: const [
                          QuickAccessCard(
                            color: Color(0xff4CB5FF),
                            icon: Ionicons.cart_outline,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Item',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          si.routerService.nextRoute(context, const AllStaff()),
                      child: Column(
                        children: const [
                          QuickAccessCard(
                            color: AppColors.primaryColor,
                            icon: Ionicons.person_outline,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Staff',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                currentUser.role == 'admin'
                    ? const Text(
                        'Top Staff',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontFamily: 'RedHatMono',
                          fontSize: 18,
                        ),
                      )
                    : Container(),
                const SizedBox(height: 12),
                currentUser.role == 'admin'
                    ? Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: FutureBuilder<List<StaffModel>>(
                          future: si.userService.getTopStaff(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: SpinKitThreeBounce(
                                  color: AppColors.primaryColor,
                                  size: 25.0,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.error.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }

                            return snapshot.data == null
                                ? const Center(
                                    child: Text('No Data!!!'),
                                  )
                                : snapshot.data!.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/search.svg',
                                              width: 120,
                                            ),
                                            const Text(
                                              'No Staff Added Yet!',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'RedHatMono',
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.length < 3
                                            ? snapshot.data!.length
                                            : 3,
                                        itemBuilder: (context, index) {
                                          StaffModel staff =
                                              snapshot.data![index];
                                          return GestureDetector(
                                            onTap: () => si.routerService
                                                .nextRoute(context,
                                                    SingleStaff(staff: staff)),
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text('${index + 1}'),
                                                      SizedBox(
                                                        width: 100,
                                                        child: Image.asset(
                                                          'assets/images/avater1.png',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 4.0),
                                                  Text(
                                                    staff.displayName,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                          },
                        ),
                      )
                    : Container(),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Overview',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontFamily: 'RedHatMono',
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        FutureBuilder<MediaAnalyticsModel>(
                            future: si.analyticsService.getMediaAnalytics(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Expanded(
                                  child: AnalyticsCard(
                                    title: 'Media',
                                    quantity: '0',
                                    amount: formatMoney(0),
                                    icon: 'assets/svg/search.svg',
                                    color: Colors.green,
                                  ),
                                );
                              }
                              MediaAnalyticsModel? analyticsModel =
                                  snapshot.data;
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => si.routerService
                                      .nextRoute(context, const AllMedia()),
                                  child: AnalyticsCard(
                                    title: 'Media',
                                    quantity: formatNumber(
                                        analyticsModel == null
                                            ? 0
                                            : analyticsModel.totalQuantity),
                                    amount: formatMoney(analyticsModel == null
                                        ? 0
                                        : analyticsModel.totalAmountPaid),
                                    icon: 'assets/svg/media.svg',
                                    color: Colors.green,
                                  ),
                                ),
                              );
                            }),
                        const SizedBox(width: 15.0),
                        FutureBuilder<ItemAnalyticsModel>(
                            future: si.analyticsService
                                .getAllPurchasedItemAnalytics(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Expanded(
                                  child: AnalyticsCard(
                                    title: 'Items',
                                    quantity: '0',
                                    amount: formatMoney(0),
                                    icon: 'assets/svg/search.svg',
                                    color: Colors.green,
                                  ),
                                );
                              }
                              ItemAnalyticsModel? analyticsModel =
                                  snapshot.data;
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => si.routerService
                                      .nextRoute(context, const AllItems()),
                                  child: AnalyticsCard(
                                    title: 'Items',
                                    quantity: formatNumber(
                                        analyticsModel == null
                                            ? 0
                                            : analyticsModel.totalQuantity),
                                    amount: formatMoney(analyticsModel == null
                                        ? 0
                                        : analyticsModel.totalAmountPaid),
                                    icon: 'assets/svg/item.svg',
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                    Row(
                      children: [
                        FutureBuilder<ConnectionAnalyticsModel>(
                            future:
                                si.analyticsService.getConnectionAnalytics(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Expanded(
                                  child: AnalyticsCard(
                                    title: 'Connections',
                                    quantity: '0',
                                    amount: formatMoney(0),
                                    icon: 'assets/svg/search.svg',
                                    color: Colors.red,
                                  ),
                                );
                              }
                              ConnectionAnalyticsModel? analyticsModel =
                                  snapshot.data;
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => si.routerService.nextRoute(
                                      context, const AllConnections()),
                                  child: AnalyticsCard(
                                    title: 'Connections',
                                    quantity: formatNumber(
                                        analyticsModel == null
                                            ? 0
                                            : analyticsModel.totalQuantity),
                                    amount: formatMoney(analyticsModel == null
                                        ? 0
                                        : analyticsModel.totalAmountPaid),
                                    icon: 'assets/svg/connection.svg',
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            }),
                        const SizedBox(width: 15.0),
                        FutureBuilder<List<StaffModel>>(
                            future: si.userService.getAllStaff(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Expanded(
                                  child: AnalyticsCard(
                                    title: 'Staff',
                                    quantity: '0',
                                    amount: '',
                                    icon: 'assets/svg/search.svg',
                                    color: AppColors.primaryColor,
                                  ),
                                );
                              }
                              List<StaffModel>? staff = snapshot.data;
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => si.routerService
                                      .nextRoute(context, const AllStaff()),
                                  child: AnalyticsCard(
                                    title: 'Staff',
                                    quantity: formatNumber(
                                        staff == null ? 0 : staff.length),
                                    amount: '',
                                    icon: 'assets/svg/staff.svg',
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                    Row(
                      children: [
                        FutureBuilder<int>(
                          future: si.analyticsService.getUsersNumber('manager'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Expanded(
                                child: AnalyticsCard(
                                  title: 'Managers',
                                  quantity: '0',
                                  amount: '',
                                  icon: 'assets/svg/search.svg',
                                  color: AppColors.primaryColor,
                                ),
                              );
                            }
                            int? manager = snapshot.data;
                            return Expanded(
                              child: GestureDetector(
                                onTap: currentUser.role == 'admin'
                                    ? () => si.routerService
                                        .nextRoute(context, const AllManagers())
                                    : () {},
                                child: AnalyticsCard(
                                  title: 'Managers',
                                  quantity: formatNumber(manager ?? 0),
                                  amount: '',
                                  icon: 'assets/svg/manager.svg',
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 15.0),
                        FutureBuilder<int>(
                          future: si.analyticsService.getUsersNumber('client'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Expanded(
                                child: AnalyticsCard(
                                  title: 'Clients',
                                  quantity: '0',
                                  amount: '',
                                  icon: 'assets/svg/search.svg',
                                  color: AppColors.primaryColor,
                                ),
                              );
                            }
                            int? client = snapshot.data;
                            return Expanded(
                              child: GestureDetector(
                                child: AnalyticsCard(
                                  title: 'Clients',
                                  quantity: formatNumber(client ?? 0),
                                  amount: '',
                                  icon: 'assets/svg/client.svg',
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
