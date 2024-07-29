import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paws/utils/dio_error_utility.dart';
import 'package:paws/utils/text_styles.dart';

class CommonErrorWidget<T> extends ConsumerWidget {
  const CommonErrorWidget({
    super.key,
    required this.error,
    required this.autoDisposeFutureProvider,
  });

  final AutoDisposeFutureProvider<T> autoDisposeFutureProvider;
  final Object error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            DioErrorUtil.getErrorMessage(error),
            style: AppTextStyles.dmSans.copyWith(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            ref.invalidate(autoDisposeFutureProvider);
          },
          child: const Text(
            'Retry',
            style: AppTextStyles.dmSans,
          ),
        ),
      ],
    );
  }
}
