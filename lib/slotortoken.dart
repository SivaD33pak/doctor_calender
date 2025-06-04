import 'package:doctor_calender/tokendetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:doctor_calender/slotdetails.dart';

class SlotOrToken extends StatefulWidget {
  @override
  _SlotOrTokenState createState() => _SlotOrTokenState();
}

class _SlotOrTokenState extends State<SlotOrToken> {
  String bookingType = 'Slot';
  TimeOfDay startTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 11, minute: 0);
  int slotDuration = 20;
  int totalSlots = 6;

  double _buttonWidth = 140.0; 
  double _buttonHeight = 65.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking type',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 4),

              // CupertinoSlidingSegmentedControl with manual size adjustments
              CupertinoSlidingSegmentedControl<String>(
                groupValue: bookingType,
                backgroundColor: const Color.fromARGB(255, 54, 107, 255),
                children: {
                  'Slot': SizedBox(
                    width: _buttonWidth,
                    height: _buttonHeight,
                    child: Center(
                      child: Text(
                        'Slot',
                        style: TextStyle(
                          fontSize: 20,
                          color: bookingType == 'Slot' ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  'Token': SizedBox(
                    width: _buttonWidth,
                    height: _buttonHeight,
                    child: Center(
                      child: Text(
                        'Token',
                        style: TextStyle(
                          fontSize: 20,
                          color: bookingType == 'Token' ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                },
                onValueChanged: (value) {
                  if (value != null) {
                    setState(() {
                      bookingType = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),

              // Conditionally call SlotDetails from another file
              if (bookingType == 'Slot')
                SlotDetails(
                  startTime: startTime,
                  endTime: endTime,
                  slotDuration: slotDuration,
                  totalSlots: totalSlots,
                ),

                if (bookingType == 'Token')
                TokenDetails(
                  startTime: startTime,
                  endTime: endTime,
                  slotDuration: slotDuration,
                  totalSlots: totalSlots,
                ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}