import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:u_arewa_studio/shared/global/globals.dart';
import 'package:u_arewa_studio/shared/model/connection_model.dart';
import 'package:u_arewa_studio/shared/model/staff_model.dart';
import 'package:u_arewa_studio/shared/model/user_model.dart';

import '../servie_injector/si.dart';

class AuthService {
  Future login({required String email, required String password}) async {
    dynamic loginDetails;
    await si.firebaseService
        .login(email: email, password: password)
        .then((loggedInUserId) async {
      if (loggedInUserId.runtimeType == String) {
        await si.apiService.getRequest(
            url: Uri.parse('$baseUrl/getCustomClaim'),
            headers: {'id': loggedInUserId}).then((value) async {
          if (value.body == 'admin') {
            loginDetails = UserModel(
              uid: 'wyhbC9DM96Qky1GF6GReBZ3zGNJ2',
              email: '',
              phone: '',
              displayName: '',
              firstName: '',
              lastName: '',
              role: 'admin',
              category: '',
              status: '',
              createdAt: UserAtedAt(),
              updatedAt: UserAtedAt(),
            );
            currentUser = UserModel(
              uid: 'wyhbC9DM96Qky1GF6GReBZ3zGNJ2',
              email: '',
              phone: '',
              displayName: '',
              firstName: '',
              lastName: '',
              role: 'admin',
              category: '',
              status: '',
              createdAt: UserAtedAt(),
              updatedAt: UserAtedAt(),
            );
          } else {
            await si.userService
                .getSingleUser(id: loggedInUserId, uid: loggedInUserId)
                .then((value) {
              loginDetails = value!;
              currentUser = value;
            });
          }
        });
      } else {
        loginDetails = loggedInUserId.toString().split(']')[1];
      }
    });
    return loginDetails;
  }

  Future<dynamic> registerUser(
      {required String fName,
      required String lName,
      required String email,
      required String phone,
      required String password}) async {
    dynamic loggedInUser;
    try {
      await si.apiService.postRequest(
        url: Uri.parse('$baseUrl/createUser'),
        body: {
          'fName': fName,
          'lName': lName,
          'email': email,
          'phone': phone,
          'role': role,
          'password': password
        },
      ).then((value) {
        if (value!.statusCode != 200) {
          loggedInUser = value.message;
        } else {
          currentUser = UserModel.fromJson(value.body);
          loggedInUser = UserModel.fromJson(value.body);
        }
      });
    } catch (e) {
      loggedInUser = e.toString();
    }

    return loggedInUser;
  }

//manager
  Future<dynamic> registerManager(
      {required String fName,
      required String lName,
      required String email,
      required String phone,
      required String role,
      required String password}) async {
    dynamic manager;
    try {
      await si.apiService.postRequest(
        url: Uri.parse('$baseUrl/createManager'),
        headers: {'id': currentUser.uid},
        body: {
          'fName': fName,
          'lName': lName,
          'email': email,
          'phone': phone,
          'role': role,
          'password': password
        },
      ).then((value) {
        if (value!.statusCode != 200) {
          manager = value.message;
        } else {
          manager = UserModel.fromJson(value.body);
        }
      });
    } catch (e) {
      manager = e.toString();
    }

    return manager;
  }

  //staff
  Future<dynamic> registerStaff(
      {required String fName,
      required String lName,
      required String email,
      required String phone,
      required String category}) async {
    dynamic staff;
    try {
      await si.apiService.postRequest(
        url: Uri.parse('$baseUrl/createStaff'),
        body: {
          'fName': fName,
          'lName': lName,
          'email': email,
          'phone': phone,
          'category': category,
        },
        headers: {'id': currentUser.uid},
      ).then((value) {
        if (value!.statusCode == 200) {
          final item = value.body;
          staff = StaffModel(
            uid: item['uid'],
            email: item['email'],
            firstName: item['firstName'],
            lastName: item['lastName'],
            phone: item['phone'],
            displayName: item['displayName'],
            role: item['role'],
            category: item['category'],
            status: item['status'],
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now(),
            pictures: item['pictures'],
          );
        } else {
          staff = value.message;
        }
      });
    } catch (e) {
      staff = e.toString();
    }
    return staff;
  }

  Future<dynamic> creatConnection(
      {required String fName,
      required String lName,
      String? email,
      required String phone,
      required String conn,
      required int amount,
      required String period}) async {
    dynamic connection;
    try {
      await si.apiService.postRequest(
        url: Uri.parse('$baseUrl/createConnection'),
        body: {
          "fName": fName,
          "lName": lName,
          "email": email ?? '',
          "phone": phone,
          "connection": conn,
          "period": period,
          "amount": amount
        },
        headers: {'id': currentUser.uid},
      ).then((value) {
        if (value!.statusCode == 200) {
          connection = ConnectionModel.fromJson(value.body);
        } else {
          connection = value.message;
        }
      });
    } catch (e) {
      connection = e.toString();
    }
    return connection;
  }
}
