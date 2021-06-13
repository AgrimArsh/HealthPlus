import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine{
  String? salt;
  String? name;
  Medicine({required this.salt, required this.name});

  Map<String, dynamic> toJson(){
    return {
      "salt":this.salt,
      "name":this.name,
    };
  }

  static Medicine fromSnapshot(DocumentSnapshot snapshot){
    return Medicine(salt: snapshot.get('salt'), name: snapshot.get('name'));
  }
}