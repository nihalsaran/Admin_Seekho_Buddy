import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Materials.dart';

class Home1 extends StatefulWidget {
  final DocumentSnapshot? userData;
  final String subject;

  Home1({required this.userData, required this.subject});

  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  List<DocumentSnapshot> subjects = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  void fetchSubjects() async {
    if (widget.userData != null) {
      String faculty = widget.userData!['faculty'];
      String subfaculty = widget.userData!['subfaculty'];
      String semester = widget.userData!['semester'];

      final snapshot = await FirebaseFirestore.instance
          .collection('Material DB')
          .doc(faculty)
          .collection(subfaculty)
          .doc(semester)
          .collection('Subjects')
          .doc(widget.subject)
          .collection(widget.subject)
          .get();

      setState(() {
        subjects = snapshot.docs;
      });
    }
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
    });
  }

  List<DocumentSnapshot> _filterSubjects() {
    return subjects
        .where((subject) => subject.id
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        widget.subject,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 14, left: 14, right: 14),
            child: TextField(
              onChanged: _updateSearchQuery,
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 30.0),
              child: ListView.builder(
                itemCount: _filterSubjects().length,
                itemBuilder: (context, index) {
                  DocumentSnapshot subjectDoc = _filterSubjects()[index];
                  String subjectName = subjectDoc.id;
                  return GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 350,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(50, 50, 50, 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(35.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          subjectName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(
                                          Icons.book,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7),
                                    Text(
                                      '',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Materials(
                                            userData: widget.userData!,
                                            subject: widget.subject,
                                            documentId: subjectDoc.id,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: 230,
                                      child: Text(
                                        'View',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
