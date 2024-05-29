// dropdown_data.dart
final List<String> faculties = [
  'Faculty of Engineering',
  'Faculty of Science',
  'Faculty of Arts',
  'Faculty of Commerce',
  'Faculty of Education',
  'Faculty of Architecture',
  'DEI Technical College'
];

final Map<String, List<String>> subfaculties = {
  'Faculty of Engineering': [
    "Fulltime-Electrical",
    "Fulltime-Mechanical",
    "Fulltime-Civil",
    "Fulltime-Footwear",
    "Fulltime-Agriculture",
    "Parttime-Electrical",
    "BVoc-RE",
    "BVoc-WS",
    "BVoc-AI",
    "BVoc-WM",
    "BVoc-Automobile",
    "BVoc-DM"
  ],
  'Faculty of Science': ['Subfaculty 3', 'Subfaculty 4'],
  'Faculty of Arts': ['Subfaculty 5', 'Subfaculty 6'],
  'Faculty of Commerce': ['Subfaculty 7', 'Subfaculty 8'],
  'Faculty of Education': ['Subfaculty 9', 'Subfaculty 10'],
  'Faculty of Architecture': ['Subfaculty 11', 'Subfaculty 12'],
  'DEI Technical College': ['Subfaculty 13', 'Subfaculty 14'],
};

final Map<String, List<String>> semesters = {
  'Fulltime-Electrical': [
    'Semester 1',
    'Semester 2',
    'Semester 3',
    'Semester 4',
    'Semester 5',
    'Semester 6',
    'Semester 7',
    'Semester 8'
  ],
  'Fulltime-Mechanical': [
    'Semester 1',
    'Semester 2',
    'Semester 3',
    'Semester 4',
    'Semester 5',
    'Semester 6',
    'Semester 7',
    'Semester 8'
  ],
  // Add other subfaculties and their semesters here
};

final Map<String, List<String>> subbranches = {
  'Faculty of Engineering_Fulltime-Electrical_Semester 1': [
    'NIL',
  ],
  'Faculty of Engineering_Fulltime-Electrical_Semester 2': [
    'NIL',
  ],
  'Faculty of Engineering_Fulltime-Electrical_Semester 3': [
    'NIL',
  ],
  'Faculty of Engineering_Fulltime-Electrical_Semester 4': [
    'NIL',
  ],
  'Faculty of Engineering_Fulltime-Electrical_Semester 5': [
    'Subbranch 9',
    'Subbranch 10'
  ],
  'Faculty of Engineering_Fulltime-Electrical_Semester 6': [
    'Computer Science',
    'Subbranch 12'
  ],
  'Faculty of Engineering_Fulltime-Electrical_Semester 7': [
    'Subbranch 13',
    'Subbranch 14'
  ],
  'Faculty of Engineering_Fulltime-Electrical_Semester 8': [
    'Subbranch 15',
    'Subbranch 16'
  ],
  'Faculty of Engineering_Fulltime-Mechanical_Semester 1': [
    'NIL',
  ],
  'Faculty of Engineering_Fulltime-Mechanical_Semester 2': [
    'NIL',
  ],
  'Faculty of Engineering_Fulltime-Mechanical_Semester 3': [
    'NIL',
  ],
  'Faculty of Engineering_Fulltime-Mechanical_Semester 4': [
    'NIL',
  ],
  'Faculty of Engineering_Fulltime-Mechanical_Semester 5': [
    'Subbranch 13',
    'Subbranch 14'
  ],
  'Faculty of Engineering_Fulltime-Mechanical_Semester 6': [
    'Computer Science',
    'Subbranch 16'
  ],
  'Faculty of Engineering_Fulltime-Mechanical_Semester 7': [
    'Subbranch 17',
    'Subbranch 18'
  ],
  'Faculty of Engineering_Fulltime-Mechanical_Semester 8': [
    'Subbranch 19',
    'Subbranch 20'
  ],
  // Add other combinations of faculty, subfaculty, and semester here
};
