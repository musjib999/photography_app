import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/users/manager/add_manager.dart';

import '../../../../../../core/servie_injector/si.dart';
import '../../../../../../shared/model/user_model.dart';
import '../../../../../../shared/themes/colors.dart';

class AllManagers extends StatefulWidget {
  const AllManagers({Key? key}) : super(key: key);

  @override
  _AllManagersState createState() => _AllManagersState();
}

class _AllManagersState extends State<AllManagers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          'All Managers',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<dynamic>(
        future: si.userService.getAllUsersByRole('manager'),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Cannot get all managers'),
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
                        'No Manager Added Yet!',
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
                    UserModel manager = snapshot.data![index];
                    return ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person_outlined),
                      ),
                      title: Text(manager.displayName),
                      subtitle: Text(manager.role),
                    );
                  },
                );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            si.routerService.nextRoute(context, const AddManager()),
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
