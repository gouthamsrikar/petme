import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:petme/repositories/string_cache_repository.dart';
import '../models/pet_model.dart';

class PetRepository {
  static final StringCacheRepository _cacheRepository = StringCacheRepository();

  Future<List<Pet>> fetchPets() async {
    final data = await rootBundle.loadString('assets/pets.json');
    final List<dynamic> json = jsonDecode(data);
    return json.map((item) => Pet.fromJson(item)).toList();
  }

  Future<List<String>> getAdoptedIds() async {
    return await _cacheRepository.loadStrings("adopted_ids");
  }

  Future<List<String>> saveAdoptedId(String id) async {
    List<String> ids = await _cacheRepository.loadStrings("adopted_ids");
    if (!ids.contains(id)) {
      ids.add(id);
    }
    await _cacheRepository.saveStrings(ids, "adopted_ids");
    return ids;
  }

  Future<List<Pet>> fetcjAdoptedPets(String id) async {
    List<Pet> pets = await fetchPets();
    List<String> ids = await _cacheRepository.loadStrings("adopted_ids");

    return pets.where((pet) => ids.contains(pet.id)).toList();
  }
}
