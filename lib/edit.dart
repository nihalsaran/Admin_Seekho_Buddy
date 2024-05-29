import 'package:flutter/material.dart';

class EditField extends StatefulWidget {
  final String field;
  final String currentValue;

  EditField({required this.field, required this.currentValue});

  @override
  _EditFieldState createState() => _EditFieldState();
}

class _EditFieldState extends State<EditField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white), // Set back button icon color to white
        title: Text(
          'Edit ${widget.field}',
          style: TextStyle(
              color: Colors.white), // Set the title text color to white
        ),
        backgroundColor:
            Colors.black, // Set the background color of the AppBar (optional)
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Colors.white), // Change to back_arrow_ios
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft, // Align the text to the left
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Color(
                      0xFF212121), // Set the background color of the box to gray
                  borderRadius:
                      BorderRadius.circular(40.0), // Set border radius
                ),
                child: Text(
                  widget.field,
                  style: TextStyle(
                      color: const Color.fromARGB(
                          255, 255, 255, 255)), // Set text color to black
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Color(
                    0xFF212121), // Set the background color of the box to gray
                borderRadius: BorderRadius.circular(30.0), // Set border radius
              ),
              child: TextField(
                controller: _controller,
                style: TextStyle(
                    color: const Color.fromARGB(
                        255, 255, 255, 255)), // Set the text color to black
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none, // Remove border
                  ),
                  filled: true,
                  fillColor: Color(
                      0xFF212121), // Set the background color of the TextField
                  hintText: 'Enter ${widget.field}', // Set placeholder text
                  hintStyle: TextStyle(
                      color: const Color.fromARGB(
                          255, 255, 255, 255)), // Set placeholder text color
                  contentPadding: EdgeInsets.all(12.0), // Set content padding
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Set button color to #99D9CC
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // Set border radius
                ),
              ),
              onPressed: () {
                // Save the changes
                Navigator.pop(context, _controller.text);
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.black, // Set text color to black
                  fontWeight: FontWeight.bold, // Make text bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
