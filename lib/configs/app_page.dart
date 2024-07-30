import 'package:get/get.dart';
import 'package:hadirio/configs/app_route.dart';
import 'package:hadirio/controllers/history_admin_controller.dart';
import 'package:hadirio/controllers/history_controller.dart';
import 'package:hadirio/controllers/home_controller.dart';
import 'package:hadirio/controllers/login_controller.dart';
import 'package:hadirio/presentations/screens/history_admin_screen.dart';
import 'package:hadirio/presentations/screens/history_screen.dart';
import 'package:hadirio/presentations/screens/home_screen.dart';
import 'package:hadirio/presentations/screens/login_screen.dart';
import 'package:hadirio/presentations/screens/off_day_presence.dart';
import 'package:hadirio/presentations/screens/profile_screen.dart';
import 'package:hadirio/presentations/screens/sick_presence_screen.dart';
import 'package:hadirio/presentations/screens/splash_screen.dart';
import 'package:hadirio/presentations/screens/welcome_screen.dart';

class AppPage {
  AppPage._();

  static List<GetPage> pages = [
    GetPage(
      name: AppRoute.login,
      page: () => LoginScreen(),
      binding: BindingsBuilder.put(() => LoginController()),
    ),
    GetPage(
      name: AppRoute.home,
      page: () => const HomeScreen(),
      binding: BindingsBuilder.put(() => HomeController()),
    ),
    GetPage(
      name: AppRoute.history,
      page: () => const HistoryScreen(),
      binding: BindingsBuilder.put(() => HistoryController()),
    ),
    GetPage(
      name: AppRoute.historyAdmin,
      page: () => const HistoryAdminScreen(),
      binding: BindingsBuilder.put(() => HistoryAdminController()),
    ),
    GetPage(
      name: AppRoute.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoute.welcome,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: AppRoute.profile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: AppRoute.offDayPresence,
      page: () => OffDayPresence(),
    ),
    GetPage(
      name: AppRoute.sickPresence,
      page: () => const SickPresenceScreen(),
    ),
  ];
}
