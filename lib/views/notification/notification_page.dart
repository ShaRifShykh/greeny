import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/services/notification_service.dart';
import 'package:greeny/values/common.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:greeny/views/notification/notification_helper.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  void getNotifications() {
    Provider.of<NotificationService>(context, listen: false).getNotifications();
  }

  @override
  void initState() {
    getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var notifications = Provider.of<NotificationService>(context, listen: true);

    return Scaffold(
      backgroundColor: ConstantColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notifications",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notifications.notifications.length,
            itemBuilder: (context, index) {
              return Provider.of<NotificationHelper>(context, listen: false)
                  .notification(
                context: context,
                createdAt: Common().convertToAgo(DateTime.parse(
                    notifications.notifications[index].createdAt)),
                title: notifications.notifications[index].title,
                description: notifications.notifications[index].description,
                image: notifications.notifications[index].image,
              );
            },
          ),
        ),
      ),
    );
  }
}
