import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryContainer extends StatelessWidget {
  final String assetPath;
  final bool? condition;
  final String label;
  final int? value;
  final bool? intOrBool;

  const CategoryContainer({
    super.key,
    required this.assetPath,
    this.condition,
    required this.label,
    this.value,
    this.intOrBool = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: IntrinsicHeight(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: SvgPicture.asset(
                      assetPath,
                      colorFilter: intOrBool!
                          ? value! > 0
                              ? ColorFilter.mode(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  BlendMode.srcIn)
                              : ColorFilter.mode(
                                  Theme.of(context).colorScheme.secondary,
                                  BlendMode.srcIn)
                          : condition!
                              ? ColorFilter.mode(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  BlendMode.srcIn)
                              : ColorFilter.mode(
                                  Theme.of(context).colorScheme.secondary,
                                  BlendMode.srcIn),
                    ),
                  ),
                  Text(
                    label.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      color: intOrBool!
                          ? value! > 0
                              ? Theme.of(context).colorScheme.primaryContainer
                              : Theme.of(context).colorScheme.secondary
                          : condition!
                              ? Theme.of(context).colorScheme.primaryContainer
                              : Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
