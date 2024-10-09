import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dortodorpartner/Helper/colors.dart';

class CommonWithOutAppBar extends StatelessWidget {
  final Widget child;
  const CommonWithOutAppBar({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: colors.third,
        systemNavigationBarDividerColor: colors.lightGrey,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [colors.white, colors.third],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
