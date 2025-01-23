import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petme/models/pet_model.dart';
import '../../repositories/pet_repository.dart';
import 'pet_event.dart';
import 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  final PetRepository petRepository;

  List<Pet> pets = [];

  List<String> adoptedPetIds = [];

  PetBloc(this.petRepository) : super(PetLoadingState()) {
    on<FetchPetsEvent>((event, emit) async {
      try {
        pets = await petRepository.fetchPets();
        adoptedPetIds = await petRepository.getAdoptedIds();

        emit(PetLoadedState(
            pets, selectedAnimalFilter, selectedGenderFilter, adoptedPetIds));
      } catch (e) {
        log(e.toString());
        emit(PetErrorState('Failed to load pets.'));
      }
    });

    on<AdoptPetEvent>((event, emit) async {
      adoptedPetIds = await petRepository.saveAdoptedId(event.petId);

      emit(PetLoadedState(
        getFilteredPets(),
        selectedAnimalFilter,
        selectedAnimalFilter,
        adoptedPetIds,
      ));
    });

    on<PetFilterEvent>((event, emit) {
      if (state is PetLoadedState) {
        selectedAnimalFilter = event.animal ?? selectedAnimalFilter;
        selectedGenderFilter = event.gender ?? selectedGenderFilter;
        print(selectedAnimalFilter);
        print(selectedGenderFilter);

        emit(
          PetLoadedState(
            getFilteredPets(),
            selectedAnimalFilter,
            selectedGenderFilter,
            adoptedPetIds,
          ),
        );
      }
    });

    on<PetSearchEvent>((event, emit) {
      if (state is PetLoadedState) {
        searchQuery = event.query;
        emit(
          PetLoadedState(
            getFilteredPets(),
            selectedAnimalFilter,
            selectedGenderFilter,
            adoptedPetIds,
          ),
        );
      }
    });
  }

  List<Pet> getFilteredPets() {
    return pets.where((pet) {
      return (selectedAnimalFilter.toLowerCase() == "all"
              ? true
              : selectedAnimalFilter.toLowerCase() ==
                  pet.category?.toLowerCase()) &&
          (selectedGenderFilter.toLowerCase() == "all"
              ? true
              : selectedGenderFilter.toLowerCase() ==
                  pet.gender?.toLowerCase()) &&
          (((pet.petName ?? "").toLowerCase())
              .contains(searchQuery.toLowerCase()));
    }).toList();
  }

  final List<String> animalFilters = [
    "All",
    "Dog",
    "Cat",
    "Bird",
  ];
  final List<String> genderFilters = ["All", "Male", "Female"];

  String selectedAnimalFilter = "All";
  String selectedGenderFilter = "All";

  String searchQuery = "";
}
