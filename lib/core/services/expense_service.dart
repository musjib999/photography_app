import '../../shared/global/globals.dart';
import '../../shared/model/expense_model.dart';
import '../../shared/model/time_model.dart';
import '../servie_injector/si.dart';

class ExpenseService {
  Future<List<ExpenseModel>> getAllExpense(String url) async {
    List<ExpenseModel> expenseList = [];
    try {
      await si.apiService.getRequest(url: Uri.parse(url), headers: {
        'id': currentUser.uid,
      }).then((value) {
        if (value.statusCode == 200) {
          List medias = value.body.toList();
          for (var item in medias) {
            ExpenseModel expense = ExpenseModel.fromJson(item);
            expenseList.add(expense);
          }
        } else {
          expenseList = [];
        }
      });
    } catch (e) {
      expenseList.add(
        ExpenseModel(
          item: 'N/A',
          cost: 0,
          quantity: 0,
          managerId: 'N/A',
          category: 'N/A',
          createdAt: AtedAt(seconds: 0, nanoseconds: 0),
          updatedAt: AtedAt(seconds: 0, nanoseconds: 0),
        ),
      );
      throw 'Error occured $e';
    }
    return expenseList;
  }

  Future<dynamic> addExpense({
    required String managerId,
    required String item,
    required String category,
    required int quantity,
    required int cost,
  }) async {
    dynamic media;
    try {
      await si.apiService.postRequest(
        url: Uri.parse('$baseUrl/createExpenses'),
        body: {
          'managerId': managerId,
          'item': item,
          'category': category,
          'quantity': quantity,
          'cost': cost,
        },
        headers: {'id': currentUser.uid},
      ).then((value) {
        if (value!.statusCode == 200) {
          media = ExpenseModel.fromJson(value.body);
        } else {
          media = value.message;
        }
      });
    } catch (e) {
      media = e.toString();
    }
    return media;
  }
}
