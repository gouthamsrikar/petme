import 'package:equatable/equatable.dart';

abstract class PetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPetsEvent extends PetEvent {}

class AdoptPetEvent extends PetEvent {
  final String petId;

  AdoptPetEvent(this.petId);

  @override
  List<Object?> get props => [petId];
}

class PetFilterEvent extends PetEvent {
  final String? animal;
  final String? gender;

  PetFilterEvent(this.animal, this.gender);

  @override
  List<Object?> get props => [animal, gender];
}

class PetSearchEvent extends PetEvent {
  final String query;

  PetSearchEvent(this.query);

  @override
  List<Object?> get props => [query];
}
