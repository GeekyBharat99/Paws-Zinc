import 'package:flutter/material.dart';
import 'package:paws/utils/text_styles.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No data',
        style: AppTextStyles.dmSans,
      ),
    );
  }
}
