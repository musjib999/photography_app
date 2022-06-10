import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:u_arewa_studio/shared/global/globals.dart';
import 'package:u_arewa_studio/shared/model/connection_model.dart';
import 'package:u_arewa_studio/shared/model/staff_model.dart';
import 'package:u_arewa_studio/shared/model/user_model.dart';

import '../../shared/model/media_model.dart';
import '../servie_injector/si.dart';

class UserService {
  Future<UserModel?> getSingleUser(
      {required String id, required String uid}) async {
    UserModel? user;
    try {
      await si.apiService.getRequest(
          url: Uri.parse('$baseUrl/getSingleUser?id=$id'),
          headers: {
            'id': uid,
          }).then((value) {
        if (value.statusCode == 200) {
          user = UserModel.fromJson(value.body);
        } else {
          user = UserModel(
            uid: '',
            email: '',
            phone: '',
            displayName: '',
            firstName: '',
            lastName: '',
            role: '',
            category: '',
            status: '',
            createdAt: UserAtedAt(),
            updatedAt: UserAtedAt(),
          );
        }
      });
    } catch (e) {
      user = UserModel(
        uid: '',
        email: '',
        phone: '',
        displayName: '',
        firstName: '',
        lastName: '',
        role: '',
        category: '',
        status: '',
        createdAt: UserAtedAt(),
        updatedAt: UserAtedAt(),
      );
      throw 'Error occured $e';
    }
    return user;
  }

  Future<StaffModel?> getSingleStaff(String id) async {
    StaffModel? staff;
    try {
      await si.apiService.getRequest(
          url: Uri.parse('$baseUrl/getSingleStaff?id=$id'),
          headers: {
            'id': currentUser.uid,
          }).then((value) {
        if (value.statusCode == 200) {
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
            createdAt: Timestamp.fromMillisecondsSinceEpoch(
                item['createdAt']['_seconds'] * 1000),
            updatedAt: Timestamp.fromMillisecondsSinceEpoch(
                item['updatedAt']['_seconds'] * 1000),
            pictures: item['pictures'],
          );
        } else {
          staff = StaffModel(
            uid: '',
            email: '',
            phone: '',
            displayName: '',
            firstName: '',
            lastName: '',
            role: '',
            category: '',
            pictures: 0,
            status: '',
            createdAt: Timestamp.fromDate(DateTime.now()),
            updatedAt: Timestamp.fromDate(DateTime.now()),
          );
        }
      });
    } catch (e) {
      staff = StaffModel(
        uid: '',
        email: '',
        phone: '',
        displayName: '',
        firstName: '',
        lastName: '',
        role: '',
        category: '',
        status: '',
        createdAt: Timestamp.fromDate(DateTime.now()),
        updatedAt: Timestamp.fromDate(DateTime.now()),
        pictures: 0,
      );
      throw 'Error occured $e';
    }
    return staff;
  }

  Future<List<StaffModel>> getAllStaff() async {
    List<StaffModel> staffList = [];
    try {
      await si.apiService
          .getRequest(url: Uri.parse('$baseUrl/getAllStaff'), headers: {
        'id': currentUser.uid,
      }).then((value) {
        if (value.statusCode == 200) {
          List staffs = value.body.toList();
          for (var item in staffs) {
            StaffModel staff = StaffModel(
              uid: item['uid'],
              email: item['email'],
              firstName: item['firstName'],
              lastName: item['lastName'],
              phone: item['phone'],
              displayName: item['displayName'],
              role: item['role'],
              category: item['category'],
              status: item['status'],
              createdAt: Timestamp.fromMillisecondsSinceEpoch(
                  item['createdAt']['_seconds'] * 1000),
              updatedAt: Timestamp.fromMillisecondsSinceEpoch(
                  item['updatedAt']['_seconds'] * 1000),
              pictures: item['pictures'],
            );
            staffList.add(staff);
          }
        } else {
          staffList = [];
        }
      });
    } catch (e) {
      staffList = [];
      throw 'Error occured $e';
    }
    return staffList;
  }

  Future<List<StaffModel>> getTopStaff() async {
    List<StaffModel> topStaffList = [];
    try {
      await getAllStaff().then((value) {
        List<StaffModel> staffs = value;

        staffs.sort(
          (a, b) => b.pictures.compareTo(a.pictures),
        );
        topStaffList = staffs;
      });
    } catch (e) {
      topStaffList = [];
      throw 'Error occured $e';
    }
    return topStaffList;
  }

  Future<List<UserModel>> getAllUsersByRole(String role) async {
    List<UserModel> clientList = [];
    try {
      await si.apiService.getRequest(
          url: Uri.parse('$baseUrl/getAllUsersByRole?role=$role'),
          headers: {
            'id': currentUser.uid,
          }).then((value) {
        if (value.statusCode == 200) {
          List clients = value.body;
          for (dynamic item in clients) {
            UserModel client = UserModel.fromJson(item);
            clientList.add(client);
          }
        } else {
          clientList = [];
        }
      });
    } catch (e) {
      clientList = [];
      throw 'Error occured $e';
    }
    return clientList;
  }

  Future<List<StaffModel>> getAllStaffByCategory(String category) async {
    List<StaffModel> staffList = [];
    try {
      await si.apiService.getRequest(
          url: Uri.parse('$baseUrl/getAllStaffByCategory?category=$category'),
          headers: {
            'id': currentUser.uid,
          }).then((value) {
        if (value.statusCode == 200) {
          List staffs = value.body;
          for (dynamic item in staffs) {
            if (item['category'] == 'Photographer') {
              StaffModel staff = StaffModel(
                uid: item['uid'],
                email: item['email'],
                firstName: item['firstName'],
                lastName: item['lastName'],
                phone: item['phone'],
                displayName: item['displayName'],
                role: item['role'],
                category: item['category'],
                status: item['status'],
                createdAt: Timestamp.fromMillisecondsSinceEpoch(
                    item['createdAt']['_seconds'] * 1000),
                updatedAt: Timestamp.fromMillisecondsSinceEpoch(
                    item['updatedAt']['_seconds'] * 1000),
                pictures: item['pictures'],
              );
              staffList.add(staff);
            } else {
              StaffModel staff = StaffModel(
                uid: item['uid'],
                email: item['email'],
                firstName: item['firstName'],
                lastName: item['lastName'],
                phone: item['phone'],
                displayName: item['displayName'],
                role: item['role'],
                category: item['category'],
                status: item['status'],
                createdAt: Timestamp.fromMillisecondsSinceEpoch(
                    item['createdAt']['_seconds'] * 1000),
                updatedAt: Timestamp.fromMillisecondsSinceEpoch(
                    item['updatedAt']['_seconds'] * 1000),
                pictures: item['pictures'],
              );
              staffList.add(staff);
            }
          }
        } else {
          staffList = [];
        }
      });
    } catch (e) {
      staffList = [];
      throw 'Error occured $e';
    }
    return staffList;
  }

  Future<List<ConnectionModel>> getAllConnections() async {
    List<ConnectionModel> connectionList = [];
    try {
      await si.apiService
          .getRequest(url: Uri.parse('$baseUrl/getAllConnections'), headers: {
        'id': currentUser.uid,
      }).then((value) {
        if (value.statusCode == 200) {
          List connections = value.body;
          for (dynamic item in connections) {
            ConnectionModel connection = ConnectionModel.fromJson(item);
            connectionList.add(connection);
          }
        } else {
          connectionList = [];
        }
      });
    } catch (e) {
      connectionList = [];
      throw 'Error occured $e';
    }
    return connectionList;
  }

  Future<Iterable> getAllClientSuggestion(String query) async {
    List<UserModel> users = await si.userService.getAllUsersByRole('client');
    List<UserModel> suggestion = users;
    return suggestion.where((element) => true).toList();
  }

  Future<Iterable> getAllStaffPhotographersSuggestion(String query) async {
    List<StaffModel> staffs =
        await si.userService.getAllStaffByCategory('Photographer');
    List<StaffModel> suggestion = staffs;
    return suggestion.where((element) => true).toList();
  }

  Future<Iterable> getAllStaffMakeupArtistsSuggestion(String query) async {
    List<StaffModel> staffs =
        await si.userService.getAllStaffByCategory('Makeup Artist');
    List<StaffModel> suggestion = staffs;
    return suggestion.where((element) => true).toList();
  }

  Future updateUserInfo(
      {required String id, String? fName, String? lName, String? phone}) async {
    dynamic user;
    await si.apiService.postRequest(
      url: Uri.parse('$baseUrl/updateUser'),
      headers: {'id': currentUser.uid},
      body: {'id': id, 'firstName': fName, 'lastName': lName, 'phone': phone},
    ).then(
      (value) {
        if (value!.statusCode == 200) {
          user = UpdateMediaModel.fromJson(value.body);
        } else {
          user = value.message;
        }
      },
    );
    return user;
  }
}
