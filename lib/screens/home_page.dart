import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petme/blocs/pet/pet_event.dart';
import 'package:petme/blocs/theme/theme_bloc.dart';
import 'package:petme/constants/color_const.dart';
import 'package:petme/models/pet_model.dart';
import 'package:petme/screens/adopted_page.dart';
import 'package:petme/screens/search_page.dart';
import 'package:petme/src/gen/assets.gen.dart';
import 'package:petme/utils/navigation_utils.dart';
import 'package:petme/widgets/e_filled_button.dart';
import 'package:petme/widgets/e_icon_button.dart';
import 'package:petme/widgets/single_choice_chip_widget.dart';
import '../blocs/pet/pet_bloc.dart';
import '../blocs/pet/pet_state.dart';
import '../widgets/e_search_bar.dart';
import '../widgets/pet_list_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<PetBloc, PetState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            EIconButton(
                              icon: Icon(Icons.light_mode_outlined),
                              onPressed: () {
                                BlocProvider.of<ThemeBloc>(context)
                                    .add(ToggleThemeEvent());
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 22.h),
                        Hero(
                          tag: "search_bar",
                          child: ESearchBar(
                            onTap: () {
                              pushView(context, SearchPage());
                            },
                          ),
                        ),
                        SizedBox(height: 22.h),
                        CommunityCard(),
                        SizedBox(height: 22.h),
                        Hero(
                          tag: "pet_category",
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              'Pet Categories',
                              style: TextStyle(
                                color: Color(0xFF5E5B5B),
                                fontSize: 16.94,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        if (state is PetLoadedState)
                          Hero(
                            tag: "pet_choices",
                            child: SingleChoiceChipWidget(
                              options: BlocProvider.of<PetBloc>(context)
                                  .animalFilters
                                  .map((e) => SingleChoice(option: e))
                                  .toList(),
                              initialValue: state.animalFilter,
                              onSelectionChanged: (p0) {
                                BlocProvider.of<PetBloc>(context).add(
                                    PetFilterEvent(p0, state.genderFilter));
                              },
                            ),
                          ),
                        SizedBox(height: 22.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Adopt Pet',
                              style: TextStyle(
                                color: Color(0xFF5E5B5B),
                                fontSize: 16.94,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                pushView(
                                  context,
                                  AdoptedPage(),
                                );
                              },
                              child: Text(
                                'show all adopted pets',
                                style: TextStyle(
                                  color: Color(0xFF5E5B5B),
                                  fontSize: 16.94,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xFF5E5B5B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (state is PetLoadedState)
                    SizedBox(
                      height: 300.w,
                      child: ListView.separated(
                        padding: EdgeInsets.all(20.w),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => PetListItem(
                          pet: state.pets[index],
                          isAdopeted: state.adoptedPetIds.contains(
                            state.pets[index].id,
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemCount: state.pets.length,
                      ),
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CommunityCard extends StatelessWidget {
  const CommunityCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          16,
        ),
        color: ColorConst.primaryColor,
        image: DecorationImage(
          image: AssetImage(Assets.images.communityBg.path),
          alignment: Alignment.centerRight,
          fit: BoxFit.fitHeight,
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Join our animal\nlovers Community',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 1.30,
            ),
          ),
          const SizedBox(height: 10),
          EFilledButton.smallText(
            title: 'Join us',
            isExpaned: false,
            enabledColor: Colors.white,
            textColor: ColorConst.primaryColor,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
