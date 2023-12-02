import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_localization/core/animation/page_transition.dart';
import 'package:flutter_bloc_localization/features/home/pages/home_page.dart';
import 'package:flutter_bloc_localization/features/splash/manager/animation_splash_cubit.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation1;

  @override
  void initState() {
    super.initState();
    context.read<AnimationSplashCubit>().animationController;
    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
      parent: context.read<AnimationSplashCubit>().animationController,
      curve: Curves.fastLinearToSlowEaseIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    double _containerSize = 1.5;
    double _textOpacity = 0.0;
    double _containerOpacity = 0.0;
    double _fontSize = 2;

    return BlocBuilder<AnimationSplashCubit, AnimationSplashState>(
      builder: (context, state) {
        if (kDebugMode) {
          print('BlocBuilder is rebuilding with state: $state');
        }

        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: _height / _fontSize,
                  ),
                  state.maybeWhen(
                    changeTextOpacity: (textOpacity) =>
                        _buildChangeTextOpacity(textOpacity),
                    changeFontSize: (fontSize) {
                      return _buildChangeFontSize(
                          _width, _containerSize, fontSize);
                    },
                    changeContainerSizeAndOpacity:
                        (containerSize, containerOpacity) {
                      _containerSize = containerSize;
                      _containerOpacity = containerOpacity;
                      return _buildChangeContainerSizeAndOpacity(_textOpacity);
                    },
                    completed: () {
                      Future.delayed(const Duration(seconds: 1), () {
                        ///todo : make auto_route is perfect than these
                        Navigator.pushReplacement(
                            context, PageTransition(const HomePage()));
                      });
                      return const SizedBox.shrink();
                    },
                    orElse: () {
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
              Center(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  opacity: _containerOpacity,
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 2000),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: _width / _containerSize,
                      width: _width / _containerSize,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: SizerUtil.deviceType == DeviceType.mobile
                          ? FlutterLogo(
                              size: 80.h,
                            )
                          : FlutterLogo(
                              size: 120.h,
                            )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  AnimatedOpacity _buildChangeContainerSizeAndOpacity(double _textOpacity) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: _textOpacity,
      child: Text(
        'Flutter Bloc Localization',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
      ),
    );
  }

  Column _buildChangeFontSize(
      double _width, double _containerSize, double fontSize) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastLinearToSlowEaseIn,
          height: _width / _containerSize,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.fastLinearToSlowEaseIn,
            child: Text(
              'Flutter Bloc Localization',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontSize.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  AnimatedOpacity _buildChangeTextOpacity(double textOpacity) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: textOpacity,
      child: Text(
        'Flutter Bloc Localization',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}
