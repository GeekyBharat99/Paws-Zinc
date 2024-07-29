import 'package:flutter/material.dart';
import 'package:paws/screens/dog_breeds_screen.dart';
import 'package:paws/screens/random_dog_image_screen.dart';
import 'package:paws/screens/sub_breeds_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case DogBreedsScreen.route:
        return MaterialPageRoute(
          builder: (_) => const DogBreedsScreen(),
        );
      case RandomDogImageScreen.route:
        return MaterialPageRoute(
          builder: (_) {
            final breedSubBreed = (args as String).split('/');
            return RandomDogImageScreen(
              breed: breedSubBreed[0],
              subBreed: breedSubBreed[1],
            );
          },
        );
      case SubBreedsScreen.route:
        return MaterialPageRoute(
          builder: (_) => SubBreedsScreen(
            breed: args as String,
          ),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Not Found'),
          ),
          body: const Center(
            child: Text('Not Found'),
          ),
        );
      },
    );
  }
}
