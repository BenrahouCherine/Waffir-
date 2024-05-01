import 'package:flutter/material.dart';
import 'package:waffir/utils/constants/colors.dart';

class TSectionHeading extends StatelessWidget {
  const TSectionHeading(
      {super.key,
      this.textColor = TColors.dark,
      this.showActionsButton = true,
      required this.title,
      this.onPressed,
      required this.buttonTextColor // Ajoutez cette ligne
      });
  final Color? textColor;
  final bool showActionsButton;
  final String title;
  final void Function()? onPressed;
  final Color buttonTextColor; // Et cette ligne

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style:
            Theme.of(context).textTheme.headlineSmall!.apply(color: textColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }
}
