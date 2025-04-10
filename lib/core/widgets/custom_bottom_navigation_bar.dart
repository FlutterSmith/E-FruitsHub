import 'package:flutter/material.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/navigation_bar_item.dart';
import '../../exports.dart';
import '../../features/home/domain/entites/bottom_navigation_bar_entity.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 70,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 25,
            offset: Offset(0, -2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: bottomNavigationBarItems.asMap().entries.map((e) {
          final index = e.key;
          final item = e.value;
          return Expanded(
            flex: index == currentIndex ? 3 : 2,
            child: InkWell(
              onTap: () => onTabSelected(index),
              child: NavigationBarItem(
                isActive: index == currentIndex,
                bottomNavigationBarEntity: item,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
