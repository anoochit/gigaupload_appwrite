import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoadingView extends GetView {
  const LoadingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 8,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) => Card(
        elevation: 0.1,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
    );
  }
}
