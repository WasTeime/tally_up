import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/view.dart';

class LoadingOnWhiteBackgroundWidget extends StatelessWidget {
  const LoadingOnWhiteBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const LoadingWidget(),
    );
  }
}
