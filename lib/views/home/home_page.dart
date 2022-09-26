import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/services/auth_service.dart';
import 'package:greeny/application/services/banner_service.dart';
import 'package:greeny/application/services/brand_service.dart';
import 'package:greeny/application/services/category_service.dart';
import 'package:greeny/application/services/location_service.dart';
import 'package:greeny/router/route_constant.dart';
import 'package:greeny/values/common.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:greeny/views/home/home_helper.dart';
import 'package:greeny/widgets/skeleton.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  _getData() {
    Provider.of<AuthService>(context, listen: false).getUser();
    Provider.of<CategoryService>(context, listen: false).getCategories();
    Provider.of<BrandService>(context, listen: false).getBrands();
    Provider.of<BannerService>(context, listen: false).getBanners();
    Provider.of<LocationService>(context, listen: false).getLatLong();
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brandService = Provider.of<BrandService>(context, listen: true);
    var categories =
        Provider.of<CategoryService>(context, listen: true).categories;
    var location = Provider.of<LocationService>(context, listen: true);
    var banners = Provider.of<BannerService>(context, listen: true).banners;

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
        child: Column(
          children: [
            Provider.of<HomeHelper>(context, listen: false).searchBar(
                context: context,
                textEditingController: searchController,
                onSearchTap: () {
                  if (searchController.text.isNotEmpty) {
                    Navigator.pushNamed(
                      context,
                      searchRoute,
                      arguments: searchController.text,
                    );
                  } else {
                    showTopSnackBar(
                      context,
                      CustomSnackBar.error(
                        message: "Search field can't be empty!",
                        textStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 170,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                    ),
                    items: banners.map((banner) {
                      return Builder(builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              partnerDetailRoute,
                              arguments: banner.brand,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: MediaQuery.of(context).size.width,
                            height: 170,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                Common.imgUrl + "banners/" + banner.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: ConstantColors.main,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        );
                      });
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Provider.of<HomeHelper>(context, listen: false).heading(
                    title: "Top Categories",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                categoryBrandRoute,
                                arguments: categories[index],
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    Common.imgUrl +
                                        "category/Image/" +
                                        categories[index].image,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  categories[index].name,
                                  style: GoogleFonts.roboto(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Provider.of<HomeHelper>(context, listen: false).heading(
                    title: "Nearby Discounts",
                  ),
                  const SizedBox(height: 20),
                  brandService.getIsLoading
                      ? ListView.builder(
                          itemCount: brandService.brands.length,
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
                          itemCount: brandService.brands.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  partnerDetailRoute,
                                  arguments: brandService.brands[index],
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: ConstantColors.main,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.25,
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
                                                    .brands[index].image,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          brandService.brands[index].subTitle,
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
          ],
        ),
      ),
    );
  }
}
