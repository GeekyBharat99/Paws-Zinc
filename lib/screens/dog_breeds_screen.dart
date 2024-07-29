import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paws/providers/dog_breed_provider.dart';
import 'package:paws/screens/sub_breeds_screen.dart';
import 'package:paws/widgets/common_error_widget.dart';
import 'package:paws/widgets/common_list_tile.dart';
import 'package:paws/widgets/no_data_widget.dart';

class DogBreedsScreen extends ConsumerWidget {
  static const String route = 'dog_breeds_screen';
  const DogBreedsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final breedsAsyncValue = ref.watch(breedsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dog Breeds'),
        centerTitle: true,
      ),
      body: breedsAsyncValue.when(
        skipLoadingOnRefresh: false,
        data: (breeds) {
          if (breeds == null || (breeds.message?.isEmpty ?? true)) {
            return const NoDataWidget();
          }
          return ListView.builder(
            itemCount: breeds.message?.length,
            itemBuilder: (context, index) {
              return CommonListTile(
                args: breeds.message?[index] ?? "",
                routeName: SubBreedsScreen.route,
                count: index + 1,
                dogBreedOrSubBreedName: breeds.message?[index] ?? "",
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => CommonErrorWidget(
          error: error,
          autoDisposeFutureProvider: breedsProvider,
        ),
      ),
    );
  }
}
