import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/services/auth_service.dart';
import 'package:greeny/application/services/membership_service.dart';
import 'package:greeny/application/services/payment_service.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:greeny/views/membership/membership_helper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BuyMembershipPage extends StatefulWidget {
  const BuyMembershipPage({Key? key}) : super(key: key);

  @override
  State<BuyMembershipPage> createState() => _BuyMembershipPageState();
}

class _BuyMembershipPageState extends State<BuyMembershipPage> {
  void _getMemberships() {
    Provider.of<MembershipService>(context, listen: false).getMemberships();
  }

  @override
  void initState() {
    _getMemberships();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _membership = Provider.of<MembershipService>(context, listen: true);
    var _authUser = Provider.of<AuthService>(context, listen: true);

    return Scaffold(
      backgroundColor: ConstantColors.main,
      appBar: AppBar(
        backgroundColor: ConstantColors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 600,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              width: MediaQuery.of(context).size.width,
              height: _membership.memberships.length < 3
                  ? MediaQuery.of(context).size.height / 1.5
                  : null,
              decoration: const BoxDecoration(
                color: ConstantColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Hello, ${_authUser.user?.fullName}",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: ConstantColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Choose your package",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: "Become a ",
                      style: GoogleFonts.roboto(
                          color: ConstantColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                          text: "Gold User ",
                          style: GoogleFonts.roboto(
                            color: ConstantColors.yellow,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(
                          text: "from as low as possible",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _membership.memberships.length,
                    itemBuilder: (context, index) {
                      return Provider.of<MembershipHelper>(context,
                              listen: false)
                          .memberships(
                        context: context,
                        onTap: () {
                          Provider.of<PaymentService>(context, listen: false)
                              .makePayment(
                            context: context,
                            user: _authUser.user,
                            amount:
                                _membership.memberships[index].price.toString(),
                            currency: "eur",
                            membershipID:
                                _membership.memberships[index].id.toString(),
                          )
                              .then((value) {
                            if (value != null) {}
                          });
                        },
                        packageName: _membership.memberships[index].name,
                        price: _membership.memberships[index].price.toString(),
                        duration: DateFormat('dd-MM-yyyy').format(
                          DateTime.parse(
                            _membership.memberships[index].duration,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
