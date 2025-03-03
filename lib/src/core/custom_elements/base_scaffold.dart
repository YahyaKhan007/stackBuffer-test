import 'package:flutter/material.dart';
import 'package:stackbuffer_test/src/core/custom_elements/app_colors.dart';

class BaseScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget body;
  final Widget? bottom;
  final bool? top;
  final bool? safeBottom;
  final Widget? fab;

  const BaseScaffold({
    required this.body,
    this.appBar,
    this.drawer,
    this.bottom,
    this.safeBottom,
    this.top,
    this.fab,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,

      appBar: appBar,
      drawer: drawer,
      body: SafeArea(
        top: top ?? false,
        bottom: safeBottom ?? false,
        child: body,
      ),
      floatingActionButton: fab,
      bottomNavigationBar: bottom,
    );
  }
}
