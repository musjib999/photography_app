import 'package:u_arewa_studio/core/services/service_exports.dart';

class ServiceInjector {
  RouterService routerService = RouterService();
  ApiService apiService = ApiService();
  AuthService authService = AuthService();
  LocalStorageService localStorageService = LocalStorageService();
  MediaService mediaService = MediaService();
  DialogService dialogService = DialogService();
  UserService userService = UserService();
  ExpenseService expenseService = ExpenseService();
  StreamService streamService = StreamService();
  AnalyticsService analyticsService = AnalyticsService();
  ItemService itemService = ItemService();
  MakeupService makeupService = MakeupService();
  FirebaseService firebaseService = FirebaseService();
  NotificationService notificationService = NotificationService();
}

ServiceInjector si = ServiceInjector();
