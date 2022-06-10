import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/connections/add_connections.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/connections/single_connection.dart';
import 'package:u_arewa_studio/shared/model/connection_model.dart';

import '../../../../../../../shared/themes/colors.dart';

class AllConnections extends StatefulWidget {
  const AllConnections({Key? key}) : super(key: key);

  @override
  _AllConnectionsState createState() => _AllConnectionsState();
}

class _AllConnectionsState extends State<AllConnections> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          'All Connections',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<dynamic>(
        future: si.userService.getAllConnections(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Cannot get all connections',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'RedHatMono', fontSize: 20),
              ),
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
                        'No Connection Added Yet!',
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
                    ConnectionModel connection = snapshot.data![index];
                    return ListTile(
                      onTap: () => si.routerService.nextRoute(
                          context, SingleConnection(connection: connection)),
                      leading: const CircleAvatar(
                        child: Icon(Icons.person_outlined),
                      ),
                      title: Text(connection.displayName),
                      subtitle: Text(connection.connection),
                      trailing: Text(connection.contractPeriod),
                    );
                  },
                );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            si.routerService.nextRoute(context, const AddConnection()),
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
