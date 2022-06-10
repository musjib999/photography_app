import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/users/staff/add_staff.dart';
import 'package:u_arewa_studio/module/admin/screens/tabs/users/staff/single_staff.dart';
import 'package:u_arewa_studio/shared/model/staff_model.dart';

import '../../../../../../shared/themes/colors.dart';

class AllStaff extends StatefulWidget {
  const AllStaff({Key? key}) : super(key: key);

  @override
  _AllStaffState createState() => _AllStaffState();
}

class _AllStaffState extends State<AllStaff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          'All Staff',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<dynamic>(
        stream: si.streamService.getDocStream('staff'),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Cannot get all staff'),
            );
          }

          final data = snapshot.data!.docs;
          return data.isEmpty
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svg/search.svg', width: 180),
                      const Text(
                        'No Staff Added Yet!',
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
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    StaffModel staff = StaffModel.fromJson(data[index].data());
                    return ListTile(
                      onTap: () => si.routerService.nextRoute(
                        context,
                        SingleStaff(staff: staff),
                      ),
                      leading: const CircleAvatar(
                        child: Icon(Icons.person_outlined),
                      ),
                      title: Text(staff.displayName),
                      subtitle: Text(staff.category),
                    );
                  },
                );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => si.routerService.nextRoute(context, const AddStaff()),
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
