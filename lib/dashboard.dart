import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140, // Adjust the width
      height: 110, // Adjust the height
      child: CupertinoButton(
        padding: const EdgeInsets.all(4),
        // When pressed, toggle the selected state and update the background color
        color: _isSelected ? const Color.fromARGB(67, 183, 223, 255) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        onPressed: () {
          setState(() {
            _isSelected = !_isSelected;
          });
        },
        child: Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 20,
            // Change the text color depending on whether the button is selected
            color: _isSelected ? const Color.fromARGB(255, 0, 0, 0) : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}