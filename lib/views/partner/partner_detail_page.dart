// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greeny/application/models/brand.dart';
import 'package:greeny/values/common.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:greeny/views/partner/partner_helper.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class PartnerDetailPage extends StatefulWidget {
  final Brand brand;
  const PartnerDetailPage({Key? key, required this.brand}) : super(key: key);

  @override
  State<PartnerDetailPage> createState() => _PartnerDetailPageState();
}

class _PartnerDetailPageState extends State<PartnerDetailPage> {
  late VideoPlayerController _controller;
  List<Marker> allMarkers = [];

  @override
  void initState() {
    if (widget.brand.video.isNotEmpty) {
      _controller = VideoPlayerController.network(
        Common.imgUrl + "brands/video/" + widget.brand.video,
      )..initialize().then((_) {
          _controller.setLooping(true);
          _controller.play();
          setState(() {});
        });
    }
    allMarkers.add(
      Marker(
        markerId: MarkerId(widget.brand.name),
        draggable: false,
        position: LatLng(
          double.parse(widget.brand.latitude),
          double.parse(widget.brand.longitude),
        ),
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.brand.video.isNotEmpty) {
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ConstantColors.whiteColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        child: widget.brand.video.isNotEmpty
                            ? VideoPlayer(_controller)
                            : Image.network(
                                Common.imgUrl +
                                    "brands/image/" +
                                    widget.brand.image,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Provider.of<PartnerHelper>(context, listen: false)
                              .appBarIcons(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              FontAwesomeIcons.arrowLeft,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(top: 230),
                      child: TabBar(
                        indicatorColor: ConstantColors.transparent,
                        tabs: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: ConstantColors.main,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: ConstantColors.whiteColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Location",
                                  style: GoogleFonts.roboto(
                                    color: ConstantColors.whiteColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: ConstantColors.whiteColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  color: ConstantColors.main,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Info",
                                  style: GoogleFonts.roboto(
                                    color: ConstantColors.main,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.brand.name,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.brand.category!.name,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: ConstantColors.textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 500,
                  child: TabBarView(
                    children: [
                      location(),
                      info(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget location() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Provider.of<PartnerHelper>(context, listen: false).title(
            title: "Location",
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  double.parse(widget.brand.latitude),
                  double.parse(widget.brand.longitude),
                ),
                zoom: 12.0,
              ),
              markers: Set.from(allMarkers),
            ),
          ),
        ],
      ),
    );
  }

  Widget info() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Provider.of<PartnerHelper>(context, listen: false).title(
            title: "Details",
          ),
          const SizedBox(height: 30),
          Provider.of<PartnerHelper>(context, listen: false).detailList(
            context: context,
            icons: FontAwesomeIcons.phone,
            title: "Phone",
            text: widget.brand.phone,
          ),
          Provider.of<PartnerHelper>(context, listen: false).detailList(
            context: context,
            icons: FontAwesomeIcons.envelope,
            title: "Email",
            text: widget.brand.email,
          ),
          Provider.of<PartnerHelper>(context, listen: false).detailList(
            context: context,
            icons: Icons.description_outlined,
            title: "Description",
            text: widget.brand.description,
          ),
          const SizedBox(height: 30),
          Provider.of<PartnerHelper>(context, listen: false).title(
            title: "Address",
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: ConstantColors.main,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(widget.brand.address + " " + widget.brand.address2),
              )
            ],
          )
        ],
      ),
    );
  }
}
