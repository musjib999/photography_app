import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/shared/model/connection_model.dart';
import 'package:u_arewa_studio/shared/model/item_model.dart';
import 'package:u_arewa_studio/shared/model/makeup_model.dart';

import '../../shared/global/globals.dart';
import '../../shared/model/analytic_models.dart';
import '../../shared/model/expense_model.dart';
import '../../shared/model/media_model.dart';

class AnalyticsService {
  Future<int> getMonthlyExpensesCost(String month) async {
    int sum = 0;
    try {
      await si.expenseService
          .getAllExpense('$baseUrl/getAllExpensesByMonth?month=$month')
          .then((expenses) {
        for (ExpenseModel expense in expenses) {
          sum += expense.cost;
        }
      });
    } catch (e) {
      sum = 0;
      rethrow;
    }
    return sum;
  }

  Future<MediaAnalyticsModel> getMediaAnalytics() async {
    int totalAmountPaid = 0;
    int totalQuantity = 0;
    int pendingBalance = 0;
    try {
      await si.mediaService.getAllMedia('$baseUrl/getAllMedia').then((medias) {
        for (MediaModel media in medias) {
          totalAmountPaid += media.amountPaid;
          totalQuantity += media.quantity;
          pendingBalance += media.pendingBalance;
        }
      });
    } catch (e) {
      totalQuantity = 0;
      totalAmountPaid = 0;
      pendingBalance = 0;
      rethrow;
    }

    MediaAnalyticsModel analytics = MediaAnalyticsModel(
        totalAmountPaid: totalAmountPaid,
        totalQuantity: totalQuantity,
        pendingBalance: pendingBalance);
    return analytics;
  }

  Future<MediaAnalyticsModel> getMediaMonthlyAnalytics(String month) async {
    int totalAmountPaid = 0;
    int totalQuantity = 0;
    int pendingBalance = 0;
    try {
      await si.mediaService
          .getAllMedia('$baseUrl/getMediaByMonth?month=$month')
          .then((medias) {
        for (MediaModel media in medias) {
          totalAmountPaid += media.amountPaid;
          totalQuantity += media.quantity;
          pendingBalance += media.pendingBalance;
        }
      });
    } catch (e) {
      totalQuantity = 0;
      totalAmountPaid = 0;
      pendingBalance = 0;
      rethrow;
    }

    MediaAnalyticsModel analytics = MediaAnalyticsModel(
        totalAmountPaid: totalAmountPaid,
        totalQuantity: totalQuantity,
        pendingBalance: pendingBalance);
    return analytics;
  }

  Future<ItemAnalyticsModel> getItemMonthlyAnalytics(String month) async {
    int totalAmountPaid = 0;
    int totalQuantity = 0;
    int pendingBalance = 0;
    try {
      await si.itemService
          .getAllItem('$baseUrl/getItemByMonth?month=$month')
          .then((items) {
        for (ItemModel media in items) {
          totalAmountPaid += media.amountPaid;
          totalQuantity += media.quantity;
          pendingBalance += media.pendingBalance;
        }
      });
    } catch (e) {
      totalQuantity = 0;
      totalAmountPaid = 0;
      pendingBalance = 0;
      rethrow;
    }

    ItemAnalyticsModel analytics = ItemAnalyticsModel(
      totalAmountPaid: totalAmountPaid,
      totalQuantity: totalQuantity,
      pendingBalance: pendingBalance,
    );
    return analytics;
  }

  Future<ConnectionAnalyticsModel> getConnectionAnalytics() async {
    int totalAmountPaid = 0;
    int totalQuantity = 0;
    try {
      await si.userService.getAllConnections().then((connections) {
        totalQuantity += connections.length;
        for (ConnectionModel connection in connections) {
          totalAmountPaid += connection.amountPaid;
        }
      });
    } catch (e) {
      totalQuantity = 0;
      totalAmountPaid = 0;
      rethrow;
    }
    ConnectionAnalyticsModel analytics = ConnectionAnalyticsModel(
        totalAmountPaid: totalAmountPaid, totalQuantity: totalQuantity);
    return analytics;
  }

  Future<ItemAnalyticsModel> getAllPurchasedItemAnalytics() async {
    int totalAmountPaid = 0;
    int totalQuantity = 0;
    int totalPendingBalance = 0;

    int totalItemAmountPaid = 0;
    int totalItemQuantity = 0;
    int totalItemPendingBalance = 0;

    int totalMakeupAmountPaid = 0;
    int totalMakeupQuantity = 0;
    int totalMakeupPendingBalance = 0;

    try {
      await si.itemService
          .getAllItem('$baseUrl/getAllItems')
          .then((items) async {
        for (ItemModel item in items) {
          totalItemAmountPaid += item.amountPaid;
          totalItemPendingBalance += item.pendingBalance;
          totalItemQuantity += item.quantity;
        }
        await si.makeupService
            .getAllMakeup('$baseUrl/getAllMakeup')
            .then((makeups) {
          for (MakeupModel makeup in makeups) {
            totalMakeupAmountPaid += makeup.amountPaid;
            totalMakeupPendingBalance += makeup.pendingBalance;
            totalMakeupQuantity += makeup.numberOfFaces;
          }
          totalAmountPaid = totalMakeupAmountPaid + totalItemAmountPaid;
          totalPendingBalance =
              totalMakeupPendingBalance + totalItemPendingBalance;
          totalQuantity = totalItemQuantity + totalMakeupQuantity;
        });
      });
    } catch (e) {
      totalQuantity = 0;
      totalAmountPaid = 0;
    }
    return ItemAnalyticsModel(
      totalAmountPaid: totalAmountPaid,
      totalQuantity: totalQuantity,
      pendingBalance: totalPendingBalance,
    );
  }

  Future<ItemAnalyticsModel> getAllPurchasedItemAnalyticsByMonth(
      String month) async {
    int totalAmountPaid = 0;
    int totalQuantity = 0;
    int totalPendingBalance = 0;

    int totalItemAmountPaid = 0;
    int totalItemQuantity = 0;
    int totalItemPendingBalance = 0;

    int totalMakeupAmountPaid = 0;
    int totalMakeupQuantity = 0;
    int totalMakeupPendingBalance = 0;

    try {
      await si.itemService
          .getAllItem('$baseUrl/getItemByMonth?month=$month')
          .then((items) async {
        for (ItemModel item in items) {
          totalItemAmountPaid += item.amountPaid;
          totalItemPendingBalance += item.pendingBalance;
          totalItemQuantity += item.quantity;
        }
        await si.makeupService
            .getAllMakeup('$baseUrl/getMakeupByMonth?month=$month')
            .then((makeups) {
          for (MakeupModel makeup in makeups) {
            totalMakeupAmountPaid += makeup.amountPaid;
            totalMakeupPendingBalance += makeup.pendingBalance;
            totalMakeupQuantity += makeup.numberOfFaces;
          }
          totalAmountPaid = totalMakeupAmountPaid + totalItemAmountPaid;
          totalPendingBalance =
              totalMakeupPendingBalance + totalItemPendingBalance;
          totalQuantity = totalItemQuantity + totalMakeupQuantity;
        });
      });
    } catch (e) {
      totalQuantity = 0;
      totalAmountPaid = 0;
    }
    return ItemAnalyticsModel(
      totalAmountPaid: totalAmountPaid,
      totalQuantity: totalQuantity,
      pendingBalance: totalPendingBalance,
    );
  }

  Future<int> getUsersNumber(String role) async {
    int number = 0;
    try {
      await si.userService.getAllUsersByRole(role).then((users) {
        number = users.length;
      });
    } catch (e) {
      number = 0;
      rethrow;
    }
    return number;
  }

  Future<AnalyticsModel> getMonthlyTotalAmount(String month) async {
    int monthlyTotalAmountPaid = 0;
    int monthlyTotalQuantity = 0;
    int monthlyTotalPendingBalance = 0;
    int monthlyExpense = 0;

    int mediaAmountPaid = 0;
    int itemAmountPaid = 0;
    try {
      await getMediaMonthlyAnalytics(month).then((media) async {
        mediaAmountPaid += media.totalAmountPaid;
        monthlyTotalQuantity += media.totalQuantity;
        monthlyTotalPendingBalance += media.pendingBalance;
        // print('Media amount Paid $mediaAmountPaid');

        // await getAllPurchasedItemAnalyticsByMonth(month).then((item) {
        //   itemAmountPaid += item.totalAmountPaid;
        //   print('Item amount paid $itemAmountPaid');
        // });

        await getMonthlyExpensesCost(month).then((expense) {
          monthlyExpense += expense;
        });
        monthlyTotalAmountPaid = mediaAmountPaid + itemAmountPaid;
        // print('Total Amount Paid $monthlyTotalAmountPaid');
      });
    } catch (e) {
      monthlyExpense = 0;
      monthlyTotalAmountPaid = 0;
      monthlyTotalPendingBalance = 0;
      monthlyTotalQuantity = 0;
    }
    return AnalyticsModel(
      monthlyTotalAmountPaid: monthlyTotalAmountPaid,
      monthlyTotalExpense: monthlyExpense,
      monthlyTotalPendingBalance: monthlyTotalPendingBalance,
      monthlyTotalQuantity: monthlyTotalQuantity,
    );
  }
}
