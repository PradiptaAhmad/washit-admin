import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/navigation/bindings/controllers/transaction_page.controller.binding.dart';

import 'package:washit_admin/infrastructure/navigation/navigation_menu.dart';
import 'package:washit_admin/presentation/transaction_page/transaction_page.screen.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
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
    GetPage(
      name: Routes.NAVBAR,
      page: () => NavigationMenu(),
    ),
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
      page: () => const SettingsPageScreen(),
      binding: SettingsPageControllerBinding(),

    ),
  ];
}
