import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/shared/model/makeup_model.dart';

import '../../shared/global/globals.dart';

class MakeupService {
  Future<dynamic> addMakeup({
    required String managerId,
    required String userId,
    required String staffId,
    required String makeupType,
    required int faces,
    required int amountPaid,
    required int price,
  }) async {
    dynamic makeup;
    try {
      await si.apiService.postRequest(
        url: Uri.parse('$baseUrl/createMakeup'),
        body: {
          'managerId': managerId,
          'userId': userId,
          'staffId': staffId,
          'numberOfFaces': faces,
          'makeupType': makeupType,
          'amountPaid': amountPaid,
          'price': price,
        },
        headers: {'id': currentUser.uid},
      ).then((value) {
        if (value!.statusCode == 200) {
          makeup = MakeupModel.fromJson(value.body);
        } else {
          makeup = value.message;
        }
      });
    } catch (e) {
      makeup = e.toString();
    }
    return makeup;
  }

  Future<List<MakeupModel>> getAllMakeup(String url) async {
    List<MakeupModel> makeupList = [];
    try {
      await si.apiService.getRequest(url: Uri.parse(url), headers: {
        'id': currentUser.uid,
      }).then((value) {
        if (value.statusCode == 200) {
          List makeups = value.body.toList();
          for (dynamic item in makeups) {
            MakeupModel singleMakeup = MakeupModel.fromJson(item);
            makeupList.add(singleMakeup);
          }
        } else {
          makeupList = [];
        }
      });
    } catch (e) {
      makeupList.add(
        MakeupModel(
          pendingBalance: 0,
          managerId: '',
          userId: '',
          amountPaid: 0,
          numberOfFaces: 0,
          price: 0,
          makeupType: '',
          staffId: '',
          status: '',
          createdAt: MakeupAtedAt(seconds: 0, nanoseconds: 0),
          updatedAt: MakeupAtedAt(seconds: 0, nanoseconds: 0),
        ),
      );
      throw 'Error occured $e';
    }
    return makeupList;
  }
}
