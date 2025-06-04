import 'package:doctor_calender/calendar.dart';
import 'package:doctor_calender/consult.dart';
import 'package:doctor_calender/dashboard.dart';
import 'package:doctor_calender/notifications.dart';
import 'package:doctor_calender/sidenav.dart';
import 'package:doctor_calender/usersettings.dart';
import 'package:doctor_calender/slotortoken.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
    
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
    
  @override
  _HomePageState createState() => _HomePageState();
}
  
class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // State tracking for which item is selected
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'PRUVE',
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Dr',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Dashboard(),
            const SizedBox(width: 2),
            Consult(),
            const SizedBox(width: 50),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for a user',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon:
                      const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(70.0),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            const SizedBox(width: 30),
            Row(
              children: [
                NotificationsButton(),
                const SizedBox(width: 5),
                Usersettings(),
              ],
            ),
            const SizedBox(width: 20),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/docpfp.png'),
              radius: 30,
            ),
          ],
        ),
      ),
      // Body: layout side nav and main content side by side.
      body: Row(
        children: [
          // The side navigation
          SideNav(
            selectedIndex: _selectedIndex,
            onItemSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          // Main content area
          Expanded(
            child: _selectedIndex == 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // CalendarWidget will be at the top of this column.
                      CalendarWidget(),
                      // Other widgets can be added below.
                      Expanded(
                        child: SlotOrToken(),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      SideNav.menuItems[_selectedIndex].title,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}