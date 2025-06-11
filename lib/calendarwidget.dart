import 'package:doctor_calender/buttonfive.dart';
import 'package:doctor_calender/buttonfour.dart';
import 'package:doctor_calender/buttonone.dart';
import 'package:doctor_calender/buttonthree.dart';
import 'package:doctor_calender/buttontwo.dart';
import 'package:flutter/material.dart';

class CalendarWidget extends StatefulWidget {
  final Function(int) onButtonPressed; // Accepts a callback function

  const CalendarWidget({Key? key, required this.onButtonPressed}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 260,
          color: const Color.fromARGB(174, 33, 72, 243),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 30.0, right: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "SET APPOINTMENT",
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today, color: Colors.black, size: 40),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Calendar icon pressed!')),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        ButtonOne(
                          isSelected: selectedIndex == 0,
                          onPressed: () {
                            setState(() {
                              selectedIndex = 0;
                            });
                            widget.onButtonPressed(0); // Call callback function
                          },
                        ),
                        const SizedBox(width: 16),
                        ButtonTwo(
                          isSelected: selectedIndex == 1,
                          onPressed: () {
                            setState(() {
                              selectedIndex = 1;
                            });
                            widget.onButtonPressed(1);
                          },
                        ),
                        const SizedBox(width: 16),
                        ButtonThree(
                          isSelected: selectedIndex == 2,
                          onPressed: () {
                            setState(() {
                              selectedIndex = 2;
                            });
                            widget.onButtonPressed(2);
                          },
                        ),
                        const SizedBox(width: 16),
                        ButtonFour(
                          isSelected: selectedIndex == 3,
                          onPressed: () {
                            setState(() {
                              selectedIndex = 3;
                            });
                            widget.onButtonPressed(3);
                          },
                        ),
                        const SizedBox(width: 16),
                        ButtonFive(
                          isSelected: selectedIndex == 4,
                          onPressed: () {
                            setState(() {
                              selectedIndex = 4;
                            });
                            widget.onButtonPressed(4);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}