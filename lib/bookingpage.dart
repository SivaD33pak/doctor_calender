import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// A simple model for each booking session.
class SessionData {
  String title;
  String startTime;
  String endTime;
  String slotDuration;
  int totalSlots;
  bool booked;
  List<bool> toggleIsSelected;

  SessionData({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.slotDuration,
    required this.totalSlots,
    required this.booked,
    required this.toggleIsSelected,
  });
}

/// The main booking page that maintains a list of booking sessions.
class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final List<SessionData> _sessions = [];

  @override
  void initState() {
    super.initState();
    // Add the default session. Its header will show the session duration.
    _sessions.add(
      SessionData(
        title: 'Session',
        startTime: '07:30 AM',
        endTime: '11:30 AM',
        slotDuration: '01:00',
        totalSlots: 12,
        booked: false,
        toggleIsSelected: [true, false],
      ),
    );
  }

  /// Adds a new booking session with the title "Session".
  void _addNewSession() {
    setState(() {
      _sessions.add(
        SessionData(
          title: 'Session',
          startTime: '12:00 PM',
          endTime: '03:00 PM',
          slotDuration: '01:00',
          totalSlots: 10,
          booked: false,
          toggleIsSelected: [true, false],
        ),
      );
    });
  }

  /// Deletes the booking session at the given index.
  void _deleteSession(int index) {
    setState(() {
      _sessions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF0177DE);

    return Scaffold(
      body: SafeArea(
        child: _sessions.isEmpty
            // When there are no sessions, show a centered placeholder with the "Add new" button.
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'No booking sessions available.',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: _addNewSession,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          '+ Add new',
                          style: TextStyle(color: primaryBlue, fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            // When sessions exist, show the list of session widgets.
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: _sessions.asMap().entries.map((entry) {
                      int index = entry.key;
                      SessionData session = entry.value;
                      return BookingSessionWidget(
                        key: ValueKey(session),
                        session: session,
                        // Only the first session shows the inline "+ Add new" button.
                        showAddButton: index == 0,
                        onAddNew: index == 0 ? _addNewSession : null,
                        onDelete: () => _deleteSession(index),
                      );
                    }).toList(),
                  ),
                ),
              ),
      ),
    );
  }
}

/// A widget that displays a single booking session including a header and booking details.
class BookingSessionWidget extends StatefulWidget {
  final SessionData session;
  final bool showAddButton;
  final VoidCallback? onAddNew;
  final VoidCallback? onDelete;

  const BookingSessionWidget({
    Key? key,
    required this.session,
    this.showAddButton = false,
    this.onAddNew,
    this.onDelete,
  }) : super(key: key);

  @override
  _BookingSessionWidgetState createState() => _BookingSessionWidgetState();
}

class _BookingSessionWidgetState extends State<BookingSessionWidget> {
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  late TextEditingController _durationController;
  late int _totalSlots;
  // For the segmented control selection: 0 for SLOT, 1 for TOKEN.
  late int _selectedSegment;
  // _isLocked indicates whether the session fields are locked.
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    _startTimeController =
        TextEditingController(text: widget.session.startTime);
    _endTimeController =
        TextEditingController(text: widget.session.endTime);
    _durationController =
        TextEditingController(text: widget.session.slotDuration);
    _totalSlots = widget.session.totalSlots;
    _selectedSegment = widget.session.toggleIsSelected[0] ? 0 : 1;
  }

  /// Parses a time string (e.g., "07:30 AM") into a TimeOfDay.
  TimeOfDay _parseTime(String timeStr) {
    try {
      List<String> parts = timeStr.split(' ');
      if (parts.length < 2) return TimeOfDay.now();
      List<String> timeParts = parts[0].split(':');
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);
      String period = parts[1];
      if (period.toUpperCase() == 'PM' && hour < 12) {
        hour += 12;
      } else if (period.toUpperCase() == 'AM' && hour == 12) {
        hour = 0;
      }
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return TimeOfDay.now();
    }
  }

  /// Opens the time picker and updates the controller.
  Future<void> _selectTime(TextEditingController controller) async {
    final initialTime = _parseTime(controller.text);
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      final String formattedTime = MaterialLocalizations.of(context)
          .formatTimeOfDay(picked, alwaysUse24HourFormat: false);
      setState(() {
        controller.text = formattedTime;
      });
    }
  }

  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF0177DE);
    const badgeBg = Color(0xFFE6F4EA);
    const badgeText = Color(0xFF19A62D);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header showing dynamic session duration.
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  const Icon(Icons.access_time,size: 22, color: Colors.black54),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Session Duration: ${_startTimeController.text} - ${_endTimeController.text}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (widget.session.booked)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: badgeBg,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.check, size: 16, color: badgeText),
                          SizedBox(width: 4),
                          Text('Booked',
                              style: TextStyle(color: badgeText, fontSize: 14)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (widget.showAddButton && widget.onAddNew != null)
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: widget.onAddNew,
                child: const Text(
                  '+ Add new',
                  style: TextStyle(color: primaryBlue, fontSize: 14),
                ),
              ),
            if (widget.onDelete != null)
              IconButton(
                icon:
                    const Icon(Icons.delete, color: Colors.red, size: 20),
                onPressed: widget.onDelete,
              ),
          ],
        ),
        const SizedBox(height: 16),
        // Booking card.
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: primaryBlue),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose your Booking type',
                style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              // Segmented control.
              SizedBox(
                width: 140.0,
                height: 65.0,
                child: CupertinoSlidingSegmentedControl<int>(
                  groupValue: _selectedSegment,
                  backgroundColor: primaryBlue.withOpacity(0.1),
                  thumbColor: primaryBlue,
                  onValueChanged: _isLocked
                      ? (int? value) {}
                      : (int? value) {
                          if (value != null) {
                            setState(() {
                              _selectedSegment = value;
                            });
                          }
                        },
                  children: {
                    0: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'SLOT',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: _selectedSegment == 0
                              ? Colors.white
                              : primaryBlue,
                        ),
                      ),
                    ),
                    1: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'TOKEN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: _selectedSegment == 1
                              ? Colors.white
                              : primaryBlue,
                        ),
                      ),
                    ),
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Time and duration input fields.
              Row(
                children: [
                  // Start time field.
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedSegment == 0
                              ? 'Start time'
                              : 'Token Starting Time',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _startTimeController,
                          readOnly: true,
                          onTap: _isLocked
                              ? null
                              : () => _selectTime(_startTimeController),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // End time field.
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedSegment == 0
                              ? 'End time'
                              : 'Token Ending Time',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _endTimeController,
                          readOnly: true,
                          onTap: _isLocked
                              ? null
                              : () => _selectTime(_endTimeController),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Duration field.
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedSegment == 0
                              ? 'Slot duration'
                              : 'Token Duration',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _durationController,
                          readOnly: _isLocked,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Total slots row with edit icon.
              Row(
                children: [
                  const Text('Total slots:',
                      style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 8),
                  Text(
                    '$_totalSlots',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  IconButton(
                    icon:
                        const Icon(Icons.edit, color: primaryBlue),
                    onPressed: () {
                      setState(() {
                        _isLocked = false;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Set button.
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  onPressed: _isLocked
                      ? null
                      : () {
                          setState(() {
                            _isLocked = true;
                            widget.session.booked = true;
                          });
                        },
                  child: const Text('Set', style: TextStyle(fontSize: 14)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
