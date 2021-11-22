import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required int currentIndex,
    required this.onTap,
  })  : _currentIndex = currentIndex,
        super(key: key);

  final int _currentIndex;
  final void Function(int) onTap;

  static const navBarIcons = [Icons.event_note, Icons.location_on_rounded];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      elevation: 8.0,
      items: navBarIcons
          .asMap()
          .map((key, value) => MapEntry(
                key,
                BottomNavigationBarItem(
                  label: '',
                  icon: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 20.0,
                    ),
                    decoration: BoxDecoration(
                      color: _currentIndex == key
                          ? Colors.lightBlue
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Icon(value),
                  ),
                ),
              ))
          .values
          .toList(),
    );
  }
}
