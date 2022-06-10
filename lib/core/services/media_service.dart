import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/shared/model/media_model.dart';

import '../../shared/global/globals.dart';

class MediaService {
  Future<List<MediaModel>> getAllMedia(String url) async {
    List<MediaModel> mediaList = [];
    try {
      await si.apiService.getRequest(url: Uri.parse(url), headers: {
        'id': currentUser.uid,
      }).then((value) {
        if (value.statusCode == 200) {
          List medias = value.body.toList();
          for (var item in medias) {
            MediaModel media = MediaModel(
              pendingBalance: item['pendingBalance'],
              quantity: item['quantity'],
              link: item['link'],
              managerId: item['managerId'],
              userId: item['userId'],
              amountPaid: item['amountPaid'],
              category: item['category'],
              pictureType: item['pictureType'],
              staffId: item['staffId'],
              status: item['status'],
              picturePrice: item['picturePrice'],
              createdAt: Timestamp.fromMillisecondsSinceEpoch(
                  item['createdAt']['_seconds'] * 1000),
              updatedAt: Timestamp.fromMillisecondsSinceEpoch(
                  item['updatedAt']['_seconds'] * 1000),
            );
            mediaList.add(media);
          }
        } else {
          mediaList = [];
        }
      });
    } catch (e) {
      mediaList = [];
      throw 'Error occured $e';
    }
    return mediaList;
  }

  Future<dynamic> addMedia({
    required String clientId,
    required String staffId,
    required String picturetype,
    required int quantity,
    required int price,
    required int amountPaid,
    String link = '',
  }) async {
    dynamic media;
    try {
      await si.apiService.postRequest(
        url: Uri.parse('$baseUrl/createMedia'),
        body: {
          'userId': clientId,
          'staffId': staffId,
          'pictureType': picturetype,
          'quantity': quantity,
          'price': price,
          'amountPaid': amountPaid,
          'link': link,
        },
        headers: {'id': currentUser.uid},
      ).then((value) {
        if (value!.statusCode == 200) {
          final item = value.body;
          media = MediaModel(
            pendingBalance: item['pendingBalance'],
            quantity: item['quantity'],
            link: item['link'],
            managerId: item['managerId'],
            userId: item['userId'],
            amountPaid: item['amountPaid'],
            category: item['category'],
            pictureType: item['pictureType'],
            staffId: item['staffId'],
            status: item['status'],
            picturePrice: item['picturePrice'],
            createdAt: Timestamp.fromMillisecondsSinceEpoch(
                item['createdAt']['_seconds'] * 1000),
            updatedAt: Timestamp.fromMillisecondsSinceEpoch(
                item['updatedAt']['_seconds'] * 1000),
          );
        } else {
          media = value.message;
        }
      });
    } catch (e) {
      media = 'Ops! Make sure you have internet connection';
      // rethrow;
    }
    return media;
  }

  Future<dynamic> updateMedia({
    required String id,
    String? status,
    String? link,
    dynamic amountPaid,
  }) async {
    dynamic media;
    try {
      await si.apiService.postRequest(
        url: Uri.parse('$baseUrl/updateMediaPurchase'),
        body: {
          'id': id,
          'status': status,
          'amountPaid': amountPaid == null ? 0 : int.parse(amountPaid),
          'link': link,
        },
        headers: {'id': currentUser.uid},
      ).then((value) {
        if (value!.statusCode == 200) {
          media = UpdateMediaModel.fromJson(value.body);
        } else {
          media = value.message;
        }
      });
    } catch (e) {
      media = 'Ops! Make sure you have internet connection';
      // rethrow;
    }
    return media;
  }
}

//updateMediaPurchase