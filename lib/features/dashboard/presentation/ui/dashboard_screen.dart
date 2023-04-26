
import 'package:ecomm_app/features/dashboard/presentation/ui/widget/bottom_navigation_widget.dart';
import 'package:flutter/material.dart';

class DasboardScreen extends StatefulWidget {
  final Widget child;
  const DasboardScreen({Key? key, required this.child}):  super(key:key);

  @override
  State<DasboardScreen> createState() => _DasboardScreenState();
}

class _DasboardScreenState extends State<DasboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}