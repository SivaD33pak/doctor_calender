import 'package:flutter/material.dart';

class TokenDetails extends StatefulWidget {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int slotDuration;
  final int totalSlots;

  const TokenDetails({
    required this.startTime,
    required this.endTime,
    required this.slotDuration,
    required this.totalSlots,
    Key? key,
  }) : super(key: key);

  @override
  _TokenDetailsState createState() => _TokenDetailsState();
}

class _TokenDetailsState extends State<TokenDetails> {
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late TextEditingController _tokenController; // Controller for number input

  @override
  void initState() {
    super.initState();
    _startTime = widget.startTime;
    _endTime = widget.endTime;
    _tokenController = TextEditingController(
      text: widget.totalSlots.toString(),
    ); // Ensures proper initialization
  }

  @override
  void dispose() {
    if (mounted) {
      _tokenController.dispose(); // Dispose safely if widget is mounted
    }
    super.dispose();
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
        Row(
          children: [
            const SizedBox(width: 15),
            _buildSelectionColumn('Start time', _startTime.format(context), () => _selectStartTime(context)),
            const SizedBox(width: 8),
            _buildSelectionColumn('End time', _endTime.format(context), () => _selectEndTime(context)),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Set No. Of Tokens', style: TextStyle(fontSize: 22)),
                  const SizedBox(height: 8),
                  _buildNumberTextBox(),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(color: Color.fromARGB(255, 136, 136, 136), height: 20.0, indent: 50.0, endIndent: 50.0),
        const SizedBox(height: 30),
        Center(
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Token Booking Confirmed!')));
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

  Widget _buildSelectionColumn(String label, String value, VoidCallback onTap) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 8),
          GestureDetector(onTap: onTap, child: _buildSelectionContainer(value)),
        ],
      ),
    );
  }

  Widget _buildNumberTextBox() {
    return Container(
      width: 200,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: _containerDecoration(),
      child: Center(
        child: TextField(
          controller: _tokenController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22),
          decoration: const InputDecoration(border: InputBorder.none),
        ),
      ),
    );
  }

  Widget _buildSelectionContainer(String text) {
    return Container(
      width: 200,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: _containerDecoration(),
      child: Center(child: Text(text, style: const TextStyle(fontSize: 22))),
    );
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8));
  }
}