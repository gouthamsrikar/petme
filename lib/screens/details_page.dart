import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petme/blocs/pet/pet_bloc.dart';
import 'package:petme/blocs/pet/pet_event.dart';
import 'package:petme/constants/color_const.dart';
import 'package:petme/models/pet_model.dart';
import 'package:petme/utils/navigation_utils.dart';
import 'package:petme/widgets/e_filled_button.dart';
import 'package:petme/widgets/e_icon_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_zoom/widget_zoom.dart';
import '../blocs/pet/pet_state.dart';
import '../blocs/theme/theme_bloc.dart';

class DetailsPage extends StatelessWidget {
  final Pet pet;

  DetailsPage({
    Key? key,
    required this.pet,
  }) : super(key: key);

  final controller = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Positioned(
              top: 0,
              child: GestureDetector(
                onTap: () {
                  pushView(
                    context,
                    SafeArea(
                      child: Material(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(24.w),
                              child: EIconButton(
                                onPressed: () {
                                  popView(context);
                                },
                                icon: Icon(
                                  Icons.chevron_left_outlined,
                                ),
                              ),
                            ),
                            Expanded(
                              child: InteractiveViewer(
                                panEnabled: false, // Set it to false
                                minScale: 1,
                                maxScale: 2,
                                child: Hero(
                                  tag: pet.id ?? '',
                                  child: Image.network(
                                    pet.photoUrls?[0] ??
                                        '', // Replace with your image asset
                                    width: 360.w,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: pet.id ?? '',
                  child: Image.network(
                    height: 400.h,
                    width: 360.w,
                    pet.photoUrls?[0] ?? '', // Replace with your image asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: EIconButton(
                onPressed: () {
                  popView(context);
                },
                icon: Icon(
                  Icons.chevron_left_outlined,
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.5, // Start height (fraction of screen)
              minChildSize: 0.5, // Minimum height
              maxChildSize: 0.7, // Maximum height
              controller: controller,

              builder: (_, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 32.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pet.petName ?? '',
                                      style: TextStyle(
                                        color: Color(0xFF5E5B5B),
                                        fontSize: 24.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        height: 1,
                                        letterSpacing: 0.23,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                            fontSize: 14.sp,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  '\$ ${pet.price ?? ''}',
                                  style: TextStyle(
                                    color: Color(0xFF5E5B5B),
                                    fontSize: 22.59,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 1,
                                    letterSpacing: 0.23,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _petDetailsWidget(
                                    "sex", pet.gender ?? '', context),
                                _petDetailsWidget(
                                    "color", pet.color ?? '', context),
                                _petDetailsWidget(
                                    "breed", pet.breed ?? '', context),
                                _petDetailsWidget(
                                    "weight", pet.weight ?? '', context),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            _ownerDetails(),
                            SizedBox(height: 24.h),
                            Flexible(
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pet.description ?? '',
                                      style: TextStyle(
                                        color: Color(0xFFC2C2C2),
                                        fontSize: 14.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 1.50,
                                        letterSpacing: 0.13,
                                      ),
                                    ).animate().slideY().fade(),
                                    SizedBox(height: 24.h),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<PetBloc, PetState>(
                        builder: (context, state) {
                          if (state is PetLoadedState) {
                            return state.adoptedPetIds.contains(pet.id)
                                ? Container(
                                    height: 56.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: ColorConst.primaryColor
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(8.sp),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Adopted! 🎉",
                                      ),
                                    ),
                                  )
                                : EFilledButton.text(
                                    title: 'Adopt me',
                                    onPressed: () {
                                      Confetti.launch(
                                        context,
                                        options: const ConfettiOptions(
                                          particleCount: 100,
                                          spread: 70,
                                          y: 1,
                                        ),
                                      );
                                      BlocProvider.of<PetBloc>(context)
                                          .add(AdoptPetEvent(pet.id!));
                                    },
                                  );
                          }
                          return Text("Something went wrong");
                        },
                      ),
                      SizedBox(height: 24.w),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _ownerDetails() {
    return Row(
      children: [
        CircleAvatar(
          radius: 24.w,
          backgroundColor: ColorConst.primaryColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.w),
            child: Image.network(
              pet.ownerImageUrl ?? '',
            ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Owner by:',
              style: TextStyle(
                color: Color(0xFFB3AEAE),
                fontSize: 10.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.20,
                letterSpacing: 0.09,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              pet.ownerName ?? '',
              style: TextStyle(
                color: Color(0xFF5E5B5B),
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.20,
                letterSpacing: 0.13,
              ),
            )
          ],
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            launchUrl(Uri.parse("tel:${pet.ownerPhone}"));
          },
          child: CircleAvatar(
            radius: 16.w,
            backgroundColor: ColorConst.primaryColor,
            child: Icon(
              Icons.phone_outlined,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            launchUrl(Uri.parse("sms:${pet.ownerPhone}"));
          },
          child: CircleAvatar(
            radius: 16.w,
            backgroundColor: ColorConst.primaryColor,
            child: Icon(
              Icons.messenger,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  Container _petDetailsWidget(
      String title, String detail, BuildContext context) {
    return Container(
      width: 62.w,
      height: 62.w,
      decoration: ShapeDecoration(
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.94,
            color: ColorConst.primaryColor.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(7.53),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            detail,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF827397),
              fontSize: 12.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFFB4AEAE),
              fontSize: 10.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          )
        ],
      ),
    );
  }
}
