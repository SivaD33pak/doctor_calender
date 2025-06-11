import 'package:doctor_calender/bookingpage.dart';
import 'package:doctor_calender/calendarwidget.dart';
import 'package:doctor_calender/consult.dart';
import 'package:doctor_calender/dashboard.dart';
import 'package:doctor_calender/notifications.dart';
import 'package:doctor_calender/sidenav.dart';
import 'package:doctor_calender/usersettings.dart';
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
  bool showBookingPage = false;
  int selectedIndex = -1; // Track which button is selected

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
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(70.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
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

      // Body: layout side nav and main content side by side
      body: Row(
        children: [
          // Side Navigation (First in Layout)
          Expanded(
            flex: 1, // SideNav takes less space
            child: SideNav(
              selectedIndex: _selectedIndex,
              onItemSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                  showBookingPage = index == 0; // Only show SlotOrToken if first option is selected
                });
              },
            ),
          ),

          // Main Content Section - Dynamically changing based on SideNav selection
          Expanded(
            flex: 3, // Main Content takes more space
            child: Column(
              children: [
                // Display content based on selected SideNav item
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: _selectedIndex == 0
                        ? Column(
                            children: [
                              CalendarWidget(
                                onButtonPressed: (index) {
                                  setState(() {
                                    selectedIndex = index;
                                    showBookingPage = index == 0; // Show SlotOrToken only when ButtonOne is pressed
                                  });
                                },
                              ),
                              Expanded(
                                child: showBookingPage
                                    ? BookingPage()
                                    : Center(
                                        child: Text(
                                          "Select a Date",
                                          style: const TextStyle(fontSize: 24, color: Colors.grey),
                                        ),
                                      ),
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
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}