import 'package:flutter/material.dart';

class SideNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  SideNav({required this.selectedIndex, required this.onItemSelected});

  static final List<MenuItem> menuItems = [
    MenuItem(title: 'Schedule Booking', icon: Icons.calendar_today),
    MenuItem(title: 'Schedule Permanent Booking', icon: Icons.access_time),
    MenuItem(title: 'Set Reminders', icon: Icons.alarm),
    MenuItem(title: 'Messages', icon: Icons.message),
    MenuItem(title: 'Appoints', icon: Icons.show_chart),
    MenuItem(title: 'Team', icon: Icons.group),
    MenuItem(title: 'Payments', icon: Icons.payment),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.black),
          right: BorderSide(color: Colors.black),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Text(
              "Manage",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(118, 112, 112, 112).withOpacity(0.81),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                MenuItem item = menuItems[index];
                bool isSelected = index == selectedIndex;
                return GestureDetector(
                  onTap: () => onItemSelected(index), // Notify HomePage when tapped
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color.fromARGB(255, 58, 33, 243).withOpacity(0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                    child: Row(
                      children: [
                        Icon(item.icon, color: isSelected ? Colors.black : Colors.black),
                        const SizedBox(width: 12.0),
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? Colors.black : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => (index == 3) ? Divider(
                color: const Color.fromARGB(255, 136, 136, 136),
                height: 20.0,
                indent: 16.0,
                endIndent: 16.0,
              ) : SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

/// A simple model class for menu items
class MenuItem {
  final String title;
  final IconData icon;

  MenuItem({required this.title, required this.icon});
}