import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:xpanse_app/controllers/auth_controller.dart';
import 'package:xpanse_app/models/m_money.dart';
import 'package:xpanse_app/services/categories.dart';
import 'package:xpanse_app/services/transactions.dart';
import 'package:xpanse_app/services/user.dart';
import 'package:xpanse_app/services/user_data.dart';
import 'package:xpanse_app/utils/readsms.dart';
import 'package:xpanse_app/utils/snack_bar.dart';

class HomeController extends GetxController {
  final SMSParse _smsParser = SMSParse();
  final UserDataService _dataService = UserDataService();
  final TransactionService _transactionService = TransactionService();
  final CategoryService _categoryService = CategoryService();
  final UserService _userService = UserService();
  var currentIndex = 0.obs;
  final RxInt balance = 0.obs;
  final Rx<User> user = AuthService.currentUser!.obs;
  final Rxn<UserData> userData = Rxn<UserData>();
  final Rxn<UserMetaData> userMetaData = Rxn<UserMetaData>();
  final RxInt monthlyExenditure = 0.obs;
  final RxList<MoMoTransaction> transactions = <MoMoTransaction>[].obs;
  final RxList<Category> categories = <Category>[].obs;
  // Form key

  @override
  void onInit() {
    super.onInit();
    loadSms();
    loadUserData();
    loadUserMetaData();
    loadCategories();
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  void loadUserMetaData() {
    _userService.getUser(user.value.uid).then((val) {
      userMetaData.value = val;
    });
  }

  void loadSms() {
    _smsParser
        .querySMS(
      address: 'M-Money',
      sort: false,
    )
        .then((val) {
      print(
          '====================================== No of Messages ${val.length} ==================');
      final transactions = val
          .map((e) {
            try {
              final transaction = MoMoTransaction.fromMessage(e.body!);
              // return transaction;
              if (transaction.isValid()) return transaction;
              return null;
            } catch (e) {
              return null;
            }
          })
          .whereType<MoMoTransaction>()
          .toList();
      print(
          '====================================== No of Transactions ${transactions.length} ==================');
      _transactionService
          .syncTransactions(
        transactions,
        user.value.uid,
      )
          .then((val) {
        loadUserExpenditure();
        loadTransactions();
      });
    });
  }

  void loadUserData() {
    _dataService
        .getOrCreateUserData(
      user.value.uid,
      UserData(startWeek: 0, startMonth: 1, budget: 1000000),
    )
        .then((val) {
      userData.value = val;
    });
  }

  void loadUserExpenditure() async {
    final total = await _transactionService.getCurrentMonthExpenditure(
        userId: user.value.uid);
    monthlyExenditure.value = total.toInt();
    balance.value = userData.value!.budget - total.toInt();
  }

  Future<UserData?> updateUserData(UserData data) async {
    try {
      await _dataService.updateUserData(user.value.uid, data);
      userData.value = data;
      positiveMessage(message: 'User data updated successfully');
      return userData.value!;
    } catch (e) {
      Get.snackbar('Error', 'Failed to update user data: $e');
      return null;
    }
  }

  void loadTransactions() {
    _transactionService.getAllTransactions(user.value.uid).then((resp) {
      transactions.assignAll(resp);
    });
  }

  Future<void> createCategory(Category category) async {
    try {
      await _categoryService.createCategory(category);
      positiveMessage(
          message: 'Successfully created ${category.name} category');
      loadCategories();
    } catch (e) {
      negativeMessage(message: 'Failed to create category: $e');
    }
  }

  void loadCategories() {
    _categoryService.getAllCategories(user.value.uid).then((val) {
      categories.assignAll(val);
    });
  }

  Future<void> updateTransaction(MoMoTransaction transaction) async {
    try {
      await _transactionService.updateTransaction(transaction);
      positiveMessage(message: 'Category added to transaction');
      loadTransactions();
    } catch (e) {
      negativeMessage(message: 'Failed to add category to transaction: $e');
    }
  }
}
