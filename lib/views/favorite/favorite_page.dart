import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/services/brand_service.dart';
import 'package:greeny/router/route_constant.dart';
import 'package:greeny/values/common.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:greeny/widgets/skeleton.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    Provider.of<BrandService>(context, listen: false).getFeaturedBrands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var featuredBrandService = Provider.of<BrandService>(context, listen: true);

    return Scaffold(
      backgroundColor: ConstantColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Featured",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              featuredBrandService.getIsLoading
                  ? ListView.builder(
                      itemCount: featuredBrandService.featuredBrands.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Skeleton(
                            width: MediaQuery.of(context).size.width,
                            height: 180,
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: featuredBrandService.featuredBrands.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              partnerDetailRoute,
                              arguments: featuredBrandService
                                  .featuredBrands[index].brand,
                            );
                          },
                          child: Container(
                            height: 180,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: ConstantColors.main,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.25,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      alignment: Alignment.centerRight,
                                      image: NetworkImage(
                                        Common.imgUrl +
                                            "brands/image/" +
                                            featuredBrandService
                                                .featuredBrands[index]
                                                .brand!
                                                .image,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.39,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        featuredBrandService
                                                .featuredBrands[index].price
                                                .toString() +
                                            " " +
                                            featuredBrandService
                                                .featuredBrands[index].title,
                                        style: GoogleFonts.roboto(
                                          color: ConstantColors.whiteColor,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "On Your First Order",
                                        style: GoogleFonts.roboto(
                                          color: ConstantColors.whiteColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
