import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petme/screens/details_page.dart';
import 'package:petme/utils/navigation_utils.dart';
import '../constants/color_const.dart';
import '../models/pet_model.dart';

class PetListItem extends StatelessWidget {
  final Pet pet;
  final bool isAdopeted;

  const PetListItem({Key? key, required this.pet, required this.isAdopeted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushView(
            context,
            DetailsPage(
              pet: pet,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: Theme.of(context).cardColor,
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(28, 158, 158, 158),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        height: 300.w,
        width: 215.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Hero(
              tag: pet.id ?? "",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.sp),
                    topRight: Radius.circular(8.sp),
                    bottomLeft: Radius.circular(8.sp),
                    bottomRight: Radius.circular(28.sp),
                  ),
                  color: ColorConst.primaryColor.withOpacity(0.2),
                  image: DecorationImage(
                    image: NetworkImage(
                      pet.photoUrls?[0] ?? '',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.topRight,
                padding: EdgeInsets.all(12),
                child: isAdopeted
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Adopted",
                              style: TextStyle(
                                color: ColorConst.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 20,
                bottom: 16,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        pet.petName ?? '',
                        style: TextStyle(
                          color: Color(0xFF5E5B5B),
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 1,
                          letterSpacing: 0.13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 18.sp,
                            color: ColorConst.primaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            pet.ownerLocation ?? '',
                            style: TextStyle(
                              color: Color(0xFF5E5B5B),
                              fontSize: 10.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: pet.gender == "male"
                        ? Color(0x338EB1E5)
                        : Color.fromARGB(51, 225, 142, 229),
                    radius: 12.sp,
                    child: Icon(
                      pet.gender == "male" ? Icons.male : Icons.female,
                      color: pet.gender == "male"
                          ? Color(0xFF8DB0E5)
                          : Color.fromARGB(255, 229, 141, 173),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
