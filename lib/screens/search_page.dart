import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petme/blocs/pet/pet_event.dart';
import 'package:petme/models/pet_model.dart';
import 'package:petme/widgets/e_search_bar.dart';
import 'package:petme/widgets/pet_list_item.dart';
import 'package:petme/widgets/single_choice_chip_widget.dart';

import '../blocs/pet/pet_bloc.dart';
import '../blocs/pet/pet_state.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PetBloc>(context).add(PetSearchEvent(''));
        BlocProvider.of<PetBloc>(context).add(PetFilterEvent(null, "All"));
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: BlocBuilder<PetBloc, PetState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32.h),
                    Hero(
                      tag: "search_bar",
                      child: ESearchBar(
                        onChanged: (e) {
                          BlocProvider.of<PetBloc>(context)
                              .add(PetSearchEvent(e));
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
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
                          pet: state.pets[index],
                          isAdopeted: state.adoptedPetIds.contains(
                            state.pets[index].id,
                          ),
                        ),
                        itemCount: state.pets.length,
                      ))
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
