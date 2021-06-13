import 'package:health_plus/DataModel/Medicine.dart';

class UserMedicine{
  String day;
  String dosage = 'morning';
  Medicine? medicine;

  UserMedicine({required this.day,required this.dosage,required this.medicine});


}
