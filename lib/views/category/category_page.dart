import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/services/brand_service.dart';
import 'package:greeny/application/services/category_service.dart';
import 'package:greeny/application/services/location_service.dart';
import 'package:greeny/router/route_constant.dart';
import 'package:greeny/values/common.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:greeny/widgets/skeleton.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    Provider.of<CategoryService>(context, listen: false).getBrands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var location = Provider.of<LocationService>(context, listen: true);
    var categories =
        Provider.of<CategoryService>(context, listen: true).categories;
    var brandService = Provider.of<CategoryService>(context, listen: true);

    return Scaffold(
      key: _drawerKey,
      drawer: Provider.of<Common>(context, listen: false).drawer(context),
      appBar: Provider.of<Common>(context, listen: false).appBar(
        context: context,
        location: location.getUserAddress,
        onLocationPressed: () {},
        onMenuPressed: () {
          _drawerKey.currentState?.openDrawer();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              SizedBox(
                height: 25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<CategoryService>(context, listen: false)
                              .getCategoryBrands(
                                  categories[index].id.toString());
                        },
                        child: Text(
                          categories[index].name,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              brandService.isLoading
                  ? ListView.builder(
                      itemCount: brandService.categoryBrands.length,
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
                      itemCount: brandService.categoryBrands.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              partnerDetailRoute,
                              arguments: brandService.categoryBrands[index],
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
                                            brandService
                                                .categoryBrands[index].image,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "20% Off",
                                      style: GoogleFonts.roboto(
                                        color: ConstantColors.whiteColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                      ),
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
