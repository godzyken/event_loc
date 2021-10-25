import 'package:get/get.dart';

import 'package:event_loc/app/modules/add_article/bindings/add_article_binding.dart';
import 'package:event_loc/app/modules/add_article/views/add_article_view.dart';
import 'package:event_loc/app/modules/add_event/bindings/add_event_binding.dart';
import 'package:event_loc/app/modules/add_event/views/add_event_view.dart';
import 'package:event_loc/app/modules/add_publicity/bindings/add_publicity_binding.dart';
import 'package:event_loc/app/modules/add_publicity/views/add_publicity_view.dart';
import 'package:event_loc/app/modules/administration/bindings/administration_binding.dart';
import 'package:event_loc/app/modules/administration/views/administration_view.dart';
import 'package:event_loc/app/modules/alert_notification/bindings/alert_notification_binding.dart';
import 'package:event_loc/app/modules/alert_notification/views/alert_notification_view.dart';
import 'package:event_loc/app/modules/article/bindings/article_binding.dart';
import 'package:event_loc/app/modules/article/views/article_view.dart';
import 'package:event_loc/app/modules/auth/bindings/auth_binding.dart';
import 'package:event_loc/app/modules/auth/views/auth_view.dart';
import 'package:event_loc/app/modules/event/bindings/event_binding.dart';
import 'package:event_loc/app/modules/event/views/event_view.dart';
import 'package:event_loc/app/modules/home/bindings/home_binding.dart';
import 'package:event_loc/app/modules/home/views/home_view.dart';
import 'package:event_loc/app/modules/link_to_member/bindings/link_to_member_binding.dart';
import 'package:event_loc/app/modules/link_to_member/views/link_to_member_view.dart';
import 'package:event_loc/app/modules/login/bindings/login_binding.dart';
import 'package:event_loc/app/modules/login/views/login_view.dart';
import 'package:event_loc/app/modules/profil/bindings/profil_binding.dart';
import 'package:event_loc/app/modules/profil/views/profil_view.dart';
import 'package:event_loc/app/modules/publicity/bindings/publicity_binding.dart';
import 'package:event_loc/app/modules/publicity/views/publicity_view.dart';
import 'package:event_loc/app/modules/search_event/bindings/search_event_binding.dart';
import 'package:event_loc/app/modules/search_event/views/search_event_view.dart';
import 'package:event_loc/app/modules/sign_in/bindings/sign_in_binding.dart';
import 'package:event_loc/app/modules/sign_in/views/sign_in_view.dart';
import 'package:event_loc/app/modules/statistique/bindings/statistique_binding.dart';
import 'package:event_loc/app/modules/statistique/views/statistique_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_EVENT,
      page: () => SearchEventView(),
      binding: SearchEventBinding(),
    ),
    GetPage(
      name: _Paths.EVENT,
      page: () => EventView(),
      binding: EventBinding(),
    ),
    GetPage(
      name: _Paths.LINK_TO_MEMBER,
      page: () => LinkToMemberView(),
      binding: LinkToMemberBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.ADMINISTRATION,
      page: () => AdministrationView(),
      binding: AdministrationBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EVENT,
      page: () => AddEventView(),
      binding: AddEventBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ARTICLE,
      page: () => AddArticleView(),
      binding: AddArticleBinding(),
    ),
    GetPage(
      name: _Paths.ARTICLE,
      page: () => ArticleView(),
      binding: ArticleBinding(),
    ),
    GetPage(
      name: _Paths.PUBLICITY,
      page: () => PublicityView(),
      binding: PublicityBinding(),
    ),
    GetPage(
      name: _Paths.ALERT_NOTIFICATION,
      page: () => AlertNotificationView(),
      binding: AlertNotificationBinding(),
    ),
    GetPage(
      name: _Paths.STATISTIQUE,
      page: () => StatistiqueView(),
      binding: StatistiqueBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PUBLICITY,
      page: () => AddPublicityView(),
      binding: AddPublicityBinding(),
    ),
  ];
}
