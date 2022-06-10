import 'package:u_arewa_studio/shared/model/item_model.dart';

import '../../shared/global/globals.dart';
import '../servie_injector/si.dart';

class ItemService {
  Future<dynamic> addItem({
    required String managerId,
    required String userId,
    required String purchasedItem,
    required int quantity,
    required int amountPaid,
    required int price,
  }) async {
    dynamic item;
    try {
      await si.apiService.postRequest(
        url: Uri.parse('$baseUrl/createItem'),
        body: {
          'managerId': managerId,
          'userId': userId,
          'item': purchasedItem,
          'quantity': quantity,
          'amountPaid': amountPaid,
          'price': price,
        },
        headers: {'id': currentUser.uid},
      ).then((value) {
        if (value!.statusCode == 200) {
          item = ItemModel.fromJson(value.body);
        } else {
          item = value.message;
        }
      });
    } catch (e) {
      item = e.toString();
    }
    return item;
  }

  Future<List<ItemModel>> getAllItem(String url) async {
    List<ItemModel> itemList = [];
    try {
      await si.apiService.getRequest(url: Uri.parse(url), headers: {
        'id': currentUser.uid,
        'userid': currentUser.uid,
      }).then((value) {
        if (value.statusCode == 200) {
          List items = value.body.toList();
          for (dynamic item in items) {
            ItemModel singleItem = ItemModel.fromJson(item);
            itemList.add(singleItem);
          }
        } else {
          itemList = [];
        }
      });
    } catch (e) {
      itemList.add(
        ItemModel(
          pendingBalance: 0,
          item: 'N/A',
          quantity: 0,
          managerId: 'N/A',
          userId: 'N/A',
          amountPaid: 0,
          price: 0,
          createdAt: ItemAtedAt(nanoseconds: 0, seconds: 0),
          updatedAt: ItemAtedAt(seconds: 0, nanoseconds: 0),
        ),
      );
      throw 'Error occured $e';
    }
    return itemList;
  }
}
