import 'package:flutter/material.dart';

class ButtonFive extends StatelessWidget {
  final VoidCallback onPressed;
  final double borderRadius;
  final double size;
  final bool isSelected; // Selection state

  const ButtonFive({
    Key? key,
    required this.onPressed,
    this.borderRadius = 8.0,
    this.size = 120.0,
    this.isSelected = false, // Default to unselected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: isSelected ? const Color.fromARGB(71, 88, 215, 254) : Colors.white, // Changes background when selected
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: Colors.black, width: 2), // Optional border
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thu',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black, // Text turns white when selected
                  fontSize: 20,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '5',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black, // Text turns white when selected
                  fontSize: 24,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}