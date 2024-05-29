import 'package:flutter/material.dart';
import 'PdfViewer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Materials extends StatefulWidget {
  final DocumentSnapshot userData; // Add this parameter
  final String subject; // Add this parameter
  final String documentId; // Add this parameter

  Materials({
    required this.userData,
    required this.subject,
    required this.documentId,
  }); // Update the constructor to accept the parameters

  @override
  _MaterialsState createState() => _MaterialsState();
}

class _MaterialsState extends State<Materials> {
  late Future<DocumentSnapshot> _documentSnapshot;

  @override
  void initState() {
    super.initState();
    _documentSnapshot = _fetchDocument();
  }

  Future<DocumentSnapshot> _fetchDocument() async {
    String faculty = widget.userData['faculty'];
    String subfaculty = widget.userData['subfaculty'];
    String semester = widget.userData['semester'];

    return await FirebaseFirestore.instance
        .collection('Material DB')
        .doc(faculty)
        .collection(subfaculty)
        .doc(semester)
        .collection('Subjects')
        .doc(widget.subject)
        .collection(widget.subject)
        .doc(widget.documentId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            '${widget.documentId}', // Display the document ID in the app bar
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            // Navigate back when the back button is pressed
            Navigator.of(context).pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(68.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 20,
                ),
                filled: true,
                fillColor: Color(0xFF323232),
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xFF323232)),
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _documentSnapshot,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.white)));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
                child: Text('Document does not exist',
                    style: TextStyle(color: Colors.white)));
          }

          var documentData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: EdgeInsets.all(10), // Padding around the card
            child: Card(
              color: Color(0xFF323232), // Set card background color
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20), // Making the border more rounded
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: documentData.entries.expand((entry) {
                    return [
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10), // Padding inside each ListTile
                        leading: Icon(
                          Icons.folder,
                          color: Colors.white,
                        ), // Set folder icon color to white
                        title: Text(
                          entry.key,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            print('View button clicked');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfViewer(
                                  keyValue: entry.key,
                                  value: entry.value.toString(),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'View',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 255,
                                255), // Set view button background color
                          ),
                        ),
                      ),
                      if (documentData.entries.last.key !=
                          entry.key) // Add a divider if it's not the last entry
                        Divider(
                          color: Color.fromARGB(
                              255, 0, 0, 0), // Set the color of the divider
                          height: 1, // Set the height of the divider
                          thickness: 1, // Set the thickness of the divider
                        ),
                    ];
                  }).toList(),
                ),
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.black, // Setting the background color to black
    );
  }
}
