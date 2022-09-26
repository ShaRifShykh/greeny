import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/services/auth_service.dart';
import 'package:greeny/application/services/banner_service.dart';
import 'package:greeny/application/services/brand_service.dart';
import 'package:greeny/application/services/category_service.dart';
import 'package:greeny/application/services/contact_service.dart';
import 'package:greeny/application/services/extra_service.dart';
import 'package:greeny/application/services/location_service.dart';
import 'package:greeny/application/services/membership_card_service.dart';
import 'package:greeny/application/services/notification_service.dart';
import 'package:greeny/application/services/order_service.dart';
import 'package:greeny/application/services/payment_service.dart';
import 'package:greeny/application/services/search_service.dart';
import 'package:greeny/application/services/trial_service.dart';
import 'package:greeny/application/services/membership_service.dart';
import 'package:greeny/application/storage/local_storage.dart';
import 'package:greeny/router/route_constant.dart';
import 'package:greeny/router/routers.dart';
import 'package:greeny/values/branding_color.dart';
import 'package:greeny/values/common.dart';
import 'package:greeny/views/auth/auth_helper.dart';
import 'package:greeny/views/extra/extra_helper.dart';
import 'package:greeny/views/home/home_helper.dart';
import 'package:greeny/views/membership/membership_helper.dart';
import 'package:greeny/views/notification/notification_helper.dart';
import 'package:greeny/views/partner/partner_helper.dart';
import 'package:greeny/views/profile/profile_helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      "pk_live_51LEKIbIPBP8dKhwVORXymlfF39NoLdMDez3tnYbD8UAQS8jJV6hNGIz5irsncehIZ8azclkOdQRnw9euB66AB9Ax00HYB6RbQH";
  // Stripe.publishableKey =
  //     "pk_test_51LEKIbIPBP8dKhwVIuiWdeosKYs9mIYNX63KkjZoylKlWkpJS0DX71BUGWGW67OpS0myKcueRGBtg38igg8eD0Y500m7GfdAkq";
  await LocalStorage.initializeSharedPreferences();
  runApp(const GreenyApp());
}

class GreenyApp extends StatefulWidget {
  const GreenyApp({Key? key}) : super(key: key);

  @override
  State<GreenyApp> createState() => _GreenyAppState();
}

class _GreenyAppState extends State<GreenyApp> {
  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((value) => print(value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Common()),
        ChangeNotifierProvider(create: (_) => BannerService()),
        ChangeNotifierProvider(create: (_) => PaymentService()),
        ChangeNotifierProvider(create: (_) => MembershipCardService()),
        ChangeNotifierProvider(create: (_) => OrderService()),
        ChangeNotifierProvider(create: (_) => ContactService()),
        ChangeNotifierProvider(create: (_) => LocationService()),
        ChangeNotifierProvider(create: (_) => CategoryService()),
        ChangeNotifierProvider(create: (_) => SearchService()),
        ChangeNotifierProvider(create: (_) => BrandService()),
        ChangeNotifierProvider(create: (_) => NotificationService()),
        ChangeNotifierProvider(create: (_) => TrialService()),
        ChangeNotifierProvider(create: (_) => ExtraService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => MembershipService()),
        ChangeNotifierProvider(create: (_) => AuthHelper()),
        ChangeNotifierProvider(create: (_) => MembershipHelper()),
        ChangeNotifierProvider(create: (_) => PartnerHelper()),
        ChangeNotifierProvider(create: (_) => HomeHelper()),
        ChangeNotifierProvider(create: (_) => NotificationHelper()),
        ChangeNotifierProvider(create: (_) => ProfileHelper()),
        ChangeNotifierProvider(create: (_) => ExtraHelper()),
      ],
      child: MaterialApp(
        title: 'Greeny',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
          ).fontFamily,
          primarySwatch: brandingColor,
        ),
        onGenerateRoute: Routers.onGenerateRoute,
        initialRoute: splashRoute,
      ),
    );
  }
}
