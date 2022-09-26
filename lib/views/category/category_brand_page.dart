import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greeny/application/models/category.dart';
import 'package:greeny/application/services/category_service.dart';
import 'package:greeny/router/route_constant.dart';
import 'package:greeny/values/common.dart';
import 'package:greeny/values/constant_colors.dart';
import 'package:provider/provider.dart';

class CategoryBrandPage extends StatefulWidget {
  final Category category;
  const CategoryBrandPage({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryBrandPage> createState() => _CategoryBrandPageState();
}

class _CategoryBrandPageState extends State<CategoryBrandPage> {
  @override
  void initState() {
    Provider.of<CategoryService>(context, listen: false)
        .getCategoryBrands(widget.category.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brands =
        Provider.of<CategoryService>(context, listen: true).categoryBrands;

    return Scaffold(
      backgroundColor: ConstantColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.category.name,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            children: [
              ListView.builder(
                itemCount: brands.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, partnerDetailRoute,
                        arguments: brands[index]),
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
                            width: MediaQuery.of(context).size.width / 2.25,
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
                                      brands[index].image,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                brands[index].subTitle,
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
