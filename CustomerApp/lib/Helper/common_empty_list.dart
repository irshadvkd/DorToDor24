import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dorTodor24/Helper/colors.dart';

class CommonEmptyList extends StatelessWidget {
  final bool condition;
  final String icon;
  final String emptyText;
  final String notFoundText;
  final String description;
  const CommonEmptyList({
    Key? key,
    required this.condition,
    required this.icon,
    required this.emptyText,
    required this.notFoundText,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/$icon',
            width: 100,
            colorFilter: const ColorFilter.mode(
              colors.primary,
              BlendMode.srcIn,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 16, 30, 12),
            child: Text(
              condition ? emptyText : notFoundText,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
          if (condition)
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Text(
                description,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
