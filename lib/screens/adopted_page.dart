import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petme/blocs/pet/pet_bloc.dart';
import 'package:petme/blocs/pet/pet_event.dart';
import 'package:petme/blocs/pet/pet_state.dart';
import 'package:petme/utils/navigation_utils.dart';
import 'package:petme/widgets/e_icon_button.dart';
import 'package:petme/widgets/pet_list_item.dart';
import 'package:petme/widgets/single_choice_chip_widget.dart';

class AdoptedPage extends StatelessWidget {
  const AdoptedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<PetBloc, PetState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      EIconButton(
                        onPressed: () {
                          popView(context);
                        },
                        icon: Icon(
                          Icons.chevron_left_outlined,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        'Adopted Pets',
                        style: TextStyle(
                          color: Color(0xFF5E5B5B),
                          fontSize: 16.94,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.w),
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
                          BlocProvider.of<PetBloc>(context)
                              .add(PetFilterEvent(p0, state.genderFilter));
                        },
                      ),
                    ),
                  SizedBox(height: 22.h),
                  Text(
                    'Gender',
                    style: TextStyle(
                      color: Color(0xFF5E5B5B),
                      fontSize: 16.94,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  if (state is PetLoadedState)
                    SingleChoiceChipWidget(
                      options: BlocProvider.of<PetBloc>(context)
                          .genderFilters
                          .map((e) => SingleChoice(option: e))
                          .toList(),
                      initialValue: state.genderFilter,
                      onSelectionChanged: (p0) {
                        BlocProvider.of<PetBloc>(context)
                            .add(PetFilterEvent(state.animalFilter, p0));
                      },
                    ),
                  SizedBox(height: 16.h),
                  if (state is PetLoadedState)
                    Expanded(
                        child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 215 / 280,
                        crossAxisSpacing: 8.w,
                        mainAxisSpacing: 8.w,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) => PetListItem(
                        pet: state.pets
                            .where((p0) => state.adoptedPetIds.contains(p0.id))
                            .toList()[index],
                        isAdopeted: state.adoptedPetIds.contains(
                          state.pets[index].id,
                        ),
                      ),
                      itemCount: state.pets
                          .where((p0) => state.adoptedPetIds.contains(p0.id))
                          .length,
                    ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
