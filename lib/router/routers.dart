import 'package:flutter/material.dart';
import 'package:greeny/application/models/brand.dart';
import 'package:greeny/application/models/category.dart';
import 'package:greeny/router/route_constant.dart';
import 'package:greeny/views/auth/sign_in_page.dart';
import 'package:greeny/views/auth/sign_up_page.dart';
import 'package:greeny/views/category/category_brand_page.dart';
import 'package:greeny/views/extra/about_us_page.dart';
import 'package:greeny/views/extra/contact_us_page.dart';
import 'package:greeny/views/extra/privacy_policy_page.dart';
import 'package:greeny/views/extra/terms_of_service_page.dart';
import 'package:greeny/views/initial/initial_page.dart';
import 'package:greeny/views/main/main_page.dart';
import 'package:greeny/views/membership/buy_membership_page.dart';
import 'package:greeny/views/membership/membership_card_page.dart';
import 'package:greeny/views/notification/notification_page.dart';
import 'package:greeny/views/order/order_page.dart';
import 'package:greeny/views/partner/partner_detail_page.dart';
import 'package:greeny/views/profile/edit_profile_page.dart';
import 'package:greeny/views/refer/refer_page.dart';
import 'package:greeny/views/search/search_page.dart';
import 'package:greeny/views/splash/splash_page.dart';
import 'package:page_transition/page_transition.dart';

class Routers {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      // Auth Routes
      case signInRoute:
        return PageTransition(
          child: const SignInPage(),
          type: PageTransitionType.rightToLeft,
        );

      case signUpRoute:
        return PageTransition(
          child: const SignUpPage(),
          type: PageTransitionType.rightToLeft,
        );

      // Initial Route
      case initialRoute:
        return PageTransition(
          child: const InitialPage(),
          type: PageTransitionType.rightToLeft,
        );

      case buyMembershipRoute:
        return PageTransition(
          child: const BuyMembershipPage(),
          type: PageTransitionType.rightToLeft,
        );

      // Main Routes
      case mainRoute:
        return PageTransition(
          child: const MainPage(),
          type: PageTransitionType.rightToLeft,
        );

      case searchRoute:
        return PageTransition(
          child: SearchPage(
            search: args as String,
          ),
          type: PageTransitionType.rightToLeft,
        );

      case categoryBrandRoute:
        return PageTransition(
          child: CategoryBrandPage(
            category: args as Category,
          ),
          type: PageTransitionType.rightToLeft,
        );

      case editProfileRoute:
        return PageTransition(
          child: const EditProfilePage(),
          type: PageTransitionType.rightToLeft,
        );

      case partnerDetailRoute:
        return PageTransition(
          child: PartnerDetailPage(
            brand: args as Brand,
          ),
          type: PageTransitionType.rightToLeft,
        );

      case referRoute:
        return PageTransition(
          child: const ReferPage(),
          type: PageTransitionType.rightToLeft,
        );

      case membershipCardRoute:
        return PageTransition(
          child: const MembershipCardPage(),
          type: PageTransitionType.bottomToTop,
        );

      case orderRoute:
        return PageTransition(
          child: const OrderPage(),
          type: PageTransitionType.rightToLeft,
        );

      // Extra Routes
      case aboutUsRoute:
        return PageTransition(
          child: const AboutUsPage(),
          type: PageTransitionType.rightToLeft,
        );

      case contactUsRoute:
        return PageTransition(
          child: const ContactUsPage(),
          type: PageTransitionType.rightToLeft,
        );

      case tosRoute:
        return PageTransition(
          child: const TermsOfServicePage(),
          type: PageTransitionType.rightToLeft,
        );

      case ppRoute:
        return PageTransition(
          child: const PrivacyPolicyPage(),
          type: PageTransitionType.rightToLeft,
        );

      case notificationRoute:
        return PageTransition(
          child: const NotificationPage(),
          type: PageTransitionType.rightToLeft,
        );

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
