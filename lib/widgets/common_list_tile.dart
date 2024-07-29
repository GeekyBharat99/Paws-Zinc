import 'package:flutter/material.dart';
import 'package:paws/utils/extensions.dart';
import 'package:paws/utils/text_styles.dart';

class CommonListTile extends StatelessWidget {
  const CommonListTile({
    super.key,
    required this.args,
    required this.routeName,
    required this.count,
    required this.dogBreedOrSubBreedName,
  });

  final String routeName;
  final int count;
  final String dogBreedOrSubBreedName;
  final String? args;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        "$count.",
        style: AppTextStyles.dmSans,
      ),
      title: Text(
        dogBreedOrSubBreedName.capitalize(),
        style: AppTextStyles.dmSans,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          routeName,
          arguments: args,
        );
      },
    );
  }
}
