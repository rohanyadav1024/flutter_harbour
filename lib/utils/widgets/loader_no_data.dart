import 'package:flutter/material.dart';
import 'package:harbourhouse/resources/app_colors.dart';

class NoData extends StatelessWidget {
  const NoData({
    this.text,
    Key? key,
  }) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text(text??"No Data Available", style: const TextStyle(fontSize: 18, color: AppColors.accentPrimary, fontWeight: FontWeight.w500),),
    );
  }
}

class Loader extends StatelessWidget {
  const Loader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: AppColors.accentPrimary,
        color: AppColors.btnPrimary,
      ),
    );
  }
}
