import 'package:flutter/material.dart';
import '../screens/map_screen.dart';
import '../screens/table_form_screen.dart';
import '../widgets/bottom_nav_bar_widget.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen(
      {required this.index, required this.driverName, Key? key})
      : super(key: key);
  final int index;
  final String driverName;

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    _currentIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List _screens = [
      const TableFormScreen(),
      MapScreen(driverName: widget.driverName),
    ];

    void _onItemTapped(index) => setState(() => _currentIndex = index);

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar:
          BottomNavBar(currentIndex: _currentIndex, onTap: _onItemTapped),
    );
  }
}
