import 'package:cloud_firestore/cloud_firestore.dart';

class usermodel{

 // final String? id;
  final String? mobile;
  final String? name;
  final String? gender;
  final String? email;
  final String? hospital;
  final String? specialist;
  final String imagePath;

  const usermodel({
   // this.id,
    required this.mobile,
    required this.name,
    required this.gender,
    required this.specialist,
    required this.hospital,
    required this.email,
    required this.imagePath
});

  toJson(){
    return{
      "Name":name,
      "Gender":gender,
      "Mobile":mobile,
      "Email":email,
      "Specialist":specialist,
      "Hospital":hospital,
      "ProfileImage": imagePath,
    };
  }

  factory usermodel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    final data = document.data()!;
    return usermodel(
      //  id: document.id,
        mobile: data["Mobile"],
        name: data["Name"],
        gender: data["Gender"],
        specialist: data["Specialist"],
        hospital: data["Hospital"],
        email: data["Email"],
        imagePath: 'ProfileImage',
    );
  }
}