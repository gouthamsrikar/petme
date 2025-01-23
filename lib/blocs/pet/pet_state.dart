import 'package:equatable/equatable.dart';
import '../../models/pet_model.dart';

abstract class PetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PetLoadingState extends PetState {}

class PetLoadedState extends PetState {
  final List<Pet> pets;
  List<String> adoptedPetIds;
  final String animalFilter;
  final String genderFilter;

  PetLoadedState(
      this.pets, this.animalFilter, this.genderFilter, this.adoptedPetIds);

  @override
  List<Object?> get props => [
        pets,
        animalFilter,
        genderFilter,
        adoptedPetIds,
      ];
}

class PetErrorState extends PetState {
  final String message;

  PetErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
