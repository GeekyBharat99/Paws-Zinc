import 'package:paws/api/api_client.dart';
import 'package:paws/models/dog_breeds_response_model.dart';
import 'package:paws/models/random_dog_image_response_model.dart';

class ApiService {
  static final ApiService _singleton = ApiService._internal();

  factory ApiService() {
    return _singleton;
  }

  late ApiClient apiClient;

  ApiService._internal() {
    apiClient = ApiClient();
  }

  Future<DogBreedsResponseModel?> getAllDogBreeds() {
    return apiClient.get(
      '/api/breeds/list',
      parser: (data) {
        if (data == null) {
          return null;
        }
        return DogBreedsResponseModel.fromJson(data);
      },
    );
  }

  Future<DogBreedsResponseModel?> getSubBreeds({
    required String breed,
  }) {
    return apiClient.get(
      '/api/breed/$breed/list',
      parser: (data) {
        if (data == null) {
          return null;
        }
        return DogBreedsResponseModel.fromJson(data);
      },
    );
  }

  Future<RandomDogImageResponseModel?> getRandomDogImage({
    required String breed,
    required String subBreed,
  }) {
    return apiClient.get(
      '/api/breed/$breed/$subBreed/images/random',
      parser: (data) {
        if (data == null) {
          return null;
        }
        return RandomDogImageResponseModel.fromJson(data);
      },
    );
  }
}
