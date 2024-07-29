import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paws/providers/dog_breed_provider.dart';
import 'package:paws/screens/random_dog_image_screen.dart';
import 'package:paws/utils/extensions.dart';
import 'package:paws/widgets/common_error_widget.dart';
import 'package:paws/widgets/common_list_tile.dart';
import 'package:paws/widgets/no_data_widget.dart';

class SubBreedsScreen extends ConsumerWidget {
  static const String route = 'sub_breed_screen';
  final String breed;

  const SubBreedsScreen({
    super.key,
    required this.breed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subBreedsAsyncValue = ref.watch(subBreedsProvider(breed));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$breed Sub-Breeds'.capitalize(),
        ),
        centerTitle: true,
      ),
      body: subBreedsAsyncValue.when(
        skipLoadingOnRefresh: false,
        data: (subBreeds) {
          if (subBreeds == null || (subBreeds.message?.isEmpty ?? true)) {
            return const NoDataWidget();
          }
          return ListView.builder(
            itemCount: subBreeds.message?.length,
            itemBuilder: (context, index) {
              return CommonListTile(
                args: "$breed/${subBreeds.message?[index] ?? ""}",
                routeName: RandomDogImageScreen.route,
                count: index + 1,
                dogBreedOrSubBreedName: subBreeds.message?[index] ?? "",
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => CommonErrorWidget(
          error: error,
          autoDisposeFutureProvider: subBreedsProvider(breed),
        ),
      ),
    );
  }
}
