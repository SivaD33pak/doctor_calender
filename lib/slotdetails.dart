import 'package:flutter/material.dart';

class SlotDetails extends StatefulWidget {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int slotDuration;
  final int totalSlots;

  const SlotDetails({
    required this.startTime,
    required this.endTime,
    required this.slotDuration,
    required this.totalSlots,
    Key? key,
  }) : super(key: key);

  @override
  _SlotDetailsState createState() => _SlotDetailsState();
}

class _SlotDetailsState extends State<SlotDetails> {
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late int _slotDuration;

  @override
  void initState() {
    super.initState();
    _startTime = widget.startTime;
    _endTime = widget.endTime;
    _slotDuration = widget.slotDuration; // Ensure slot duration initialization
  }

  Future<void> _selectStartTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null) {
      setState(() => _startTime = picked);
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (picked != null) {
      setState(() => _endTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row for Start Time, End Time, and Slot Duration
        Row(
          children: [
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Start time', style: TextStyle(fontSize: 22)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _selectStartTime(context),
                    child: _buildSelectionContainer(_startTime.format(context)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('End time', style: TextStyle(fontSize: 22)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _selectEndTime(context),
                    child: _buildSelectionContainer(_endTime.format(context)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Slot duration', style: TextStyle(fontSize: 22)),
                  const SizedBox(height: 8),
                  Container(
                    width: 200,
                    height: 50,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: _containerDecoration(),
                    child: Center(
                      child: DropdownButton<int>(
                        value: _slotDuration,
                        icon: const Icon(Icons.arrow_drop_down),
                        underline: Container(),
                        onChanged: (int? newValue) {
                          if (newValue != null) {
                            setState(() => _slotDuration = newValue);
                          }
                        },
                        items: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text('$value min', style: const TextStyle(fontSize: 22)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(color: Color.fromARGB(255, 136, 136, 136), height: 20.0, indent: 50.0, endIndent: 50.0),
        const SizedBox(height: 16),
        Center(child: Text('Total slots available: ${widget.totalSlots}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
        const SizedBox(height: 30),
        Center(
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Slot Booking Confirmed!')));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              textStyle: const TextStyle(fontSize: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  // Helper function to build selection container
  Widget _buildSelectionContainer(String text) {
    return Container(
      width: 200,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: _containerDecoration(),
      child: Center(child: Text(text, style: const TextStyle(fontSize: 22))),
    );
  }

  // Helper function for container styling
  BoxDecoration _containerDecoration() {
    return BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8));
  }
}