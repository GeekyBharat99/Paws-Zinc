import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paws/api/api_services.dart';
import 'package:paws/models/dog_breeds_response_model.dart';
import 'package:paws/models/random_dog_image_response_model.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final breedsProvider = FutureProvider.autoDispose<DogBreedsResponseModel?>(
  (ref) async {
    final apiService = ref.watch(apiServiceProvider);
    return await apiService.getAllDogBreeds();
  },
);

final subBreedsProvider =
    FutureProvider.autoDispose.family<DogBreedsResponseModel?, String>(
  (ref, breed) async {
    final apiService = ref.watch(apiServiceProvider);
    return await apiService.getSubBreeds(breed: breed);
  },
);

final randomDogImageProvider =
    FutureProvider.autoDispose.family<RandomDogImageResponseModel?, String>(
  (ref, params) async {
    final apiService = ref.watch(apiServiceProvider);
    final breedSubBreed = params.split('/');
    return await apiService.getRandomDogImage(
      breed: breedSubBreed[0],
      subBreed: breedSubBreed[1],
    );
  },
);
