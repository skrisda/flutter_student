class Student {
  final int id;
  final String fname;
  final String lname;
  final String tel;
  final int age;

  Student({this.id, this.fname, this.lname, this.tel, this.age});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      fname: json['fname'],
      lname: json['lname'],
      tel: json['tel'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fname': fname,
        'lname': lname,
        'tel': tel,
        'age': age,
      };
}
