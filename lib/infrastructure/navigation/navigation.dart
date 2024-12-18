import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:washit_admin/infrastructure/navigation/navigation_menu.dart';
import 'package:washit_admin/presentation/chat_page/chat_page.screen.dart';
import 'package:washit_admin/presentation/fiturService_page/fiturService_page.screen.dart';
import 'package:washit_admin/presentation/history_page/history_page.screen.dart';
import 'package:washit_admin/presentation/history_transaction_page/history_transaction_page.screen.dart';
import 'package:washit_admin/presentation/transaction_page/transaction_page.screen.dart';
import 'package:washit_admin/presentation/user_detail_page/user_detail_page.screen.dart';

import '../../config.dart';
import '../../presentation/add_notification_page/add_notification_page.screen.dart';
import '../../presentation/chat_detail_page/chat_detail_page.screen.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/chat_detail_page.controller.binding.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;

  EnvironmentsBadge({required this.child});

  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(name: Routes.NAVBAR, page: () => NavigationMenu(), bindings: [
      HomePageControllerBinding(),
      TransactionPageControllerBinding(),
      HistoryPageControllerBinding(),
      SettingsPageControllerBinding(),
      UsersPageControllerBinding(),
      ChatPageControllerBinding()
    ]),
    GetPage(
      name: Routes.HOME_PAGE,
      page: () => HomePageScreen(),
      binding: HomePageControllerBinding(),
    ),
    GetPage(
      name: Routes.LOGIN_PAGE,
      page: () => const LoginPageScreen(),
      binding: LoginPageControllerBinding(),
    ),
    GetPage(
      name: Routes.REGISTER_PAGE,
      page: () => const RegisterPageScreen(),
      binding: RegisterPageControllerBinding(),
    ),
    GetPage(
      name: Routes.TRANSACTION_PAGE,
      page: () => TransactionPageScreen(),
      binding: TransactionPageControllerBinding(),
    ),
    GetPage(
      name: Routes.STATUS_PAGE,
      page: () => const StatusPageScreen(),
      binding: StatusPageControllerBinding(),
    ),
    GetPage(
      name: Routes.USERS_PAGE,
      page: () => const UsersPageScreen(),
      binding: UsersPageControllerBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS_PAGE,
      page: () => SettingPage(),
      binding: SettingsPageControllerBinding(),
    ),
    GetPage(
      name: Routes.FITUR_PAGE,
      page: () => FiturView(),
      binding: FiturPageControllerBinding(),
    ),
    GetPage(
      name: Routes.HISTORY_PAGE,
      page: () => HistoryPageScreen(),
      binding: HistoryPageControllerBinding(),
    ),
    GetPage(
      name: Routes.ADD_NOTIFICATION_PAGE,
      page: () => AddNotificationPage(),
      binding: AddNotificationPageControllerBinding(),
    ),
    GetPage(
      name: Routes.HISTORY_TRANSACTION_PAGE,
      page: () => HistoryTransactionPage(),
      binding: HistoryPageControllerBinding(),
    ),
    GetPage(
      name: Routes.USER_DETAIL_PAGE,
      page: () => UserDetailPage(),
      binding: UserDetailPageControllerBinding(),
    ),
    GetPage(
      name: Routes.CHAT_PAGE,
      page: () => ChatPage(),
      binding: ChatPageControllerBinding(),
    ),
    GetPage(
      name: Routes.CHAT_DETAIL_PAGE,
      page: () => ChatDetailPage(),
      binding: ChatDetailPageControllerBinding(),
    ),
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => const SplashScreenScreen(),
      binding: SplashScreenControllerBinding(),
    ),
  ];
}
