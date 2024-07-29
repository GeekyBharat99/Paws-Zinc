import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paws/providers/dog_breed_provider.dart';
import 'package:paws/widgets/common_error_widget.dart';
import 'package:paws/widgets/no_data_widget.dart';

class RandomDogImageScreen extends ConsumerWidget {
  static const String route = 'random_dog_image_screen';

  final String breed;
  final String subBreed;

  const RandomDogImageScreen({
    super.key,
    required this.breed,
    required this.subBreed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final randomDogImageAsyncValue =
        ref.watch(randomDogImageProvider('$breed/$subBreed'));

    return Scaffold(
      appBar: AppBar(
        title: Text('Random $breed $subBreed Image'),
        centerTitle: true,
      ),
      body: randomDogImageAsyncValue.when(
        skipLoadingOnRefresh: false,
        data: (randomDogImage) {
          if (randomDogImage == null ||
              (randomDogImage.message?.isEmpty ?? true)) {
            return const NoDataWidget();
          }
          return Center(
            child: CachedNetworkImage(
              imageUrl: randomDogImage.message ?? "",
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                size: 30,
              ),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => CommonErrorWidget(
          error: error,
          autoDisposeFutureProvider: randomDogImageProvider('$breed/$subBreed'),
        ),
      ),
    );
  }
}
