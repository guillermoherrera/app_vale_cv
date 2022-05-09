import 'dart:async';

import 'package:flutter/material.dart';

class Animator extends StatefulWidget {
  const Animator({Key? key, required this.customChild, required this.time})
      : super(key: key);

  final Widget customChild;
  final Duration time;

  @override
  State<Animator> createState() => _AnimatorState();
}

class _AnimatorState extends State<Animator>
    with SingleTickerProviderStateMixin {
  late Timer timer;
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    timer = Timer(widget.time, animationController.forward);
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: widget.customChild,
      builder: (_, widget) {
        return Opacity(
            opacity: animation.value,
            child: Transform.translate(
                offset: Offset(0.0, (1 - animation.value) * 60),
                child: widget));
      },
    );
  }
}

Timer timer = Timer(duration, () {});
Duration duration = const Duration();
wait() {
  // ignore: unnecessary_null_comparison
  if (!timer.isActive) {
    timer = Timer(const Duration(milliseconds: 120), () {
      duration = const Duration();
    });
  }
  duration += const Duration(milliseconds: 100);
  return duration;
}

class WidgetAnimator extends StatelessWidget {
  const WidgetAnimator({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Animator(customChild: child, time: wait());
  }
}
