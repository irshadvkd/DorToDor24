import 'package:flutter/material.dart';
import 'package:dortodorpartner/Helper/colors.dart';

class CommonAlert extends StatelessWidget {
  final String msg;
  final double? height;
  final void Function() onTap;
  const CommonAlert(
      {super.key, required this.msg, this.height, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 280,
        height: height ?? 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                msg,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: colors.grey.withOpacity(.1), width: 1),
                ),
                child: Text(
                  'OK',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: colors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
