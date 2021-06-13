import 'package:health_plus/DataModel/Medicine.dart';

List<String> BirthTo15Months = ["Hepatitis B : 1st dose", "Hepatitis B : 2nd dose", "Hepatitis B : 3rd dose", "Rotavirus: 1st dose", "Rotavirus : 2nd dose", "DTaP : 1st dose", "DTaP : 2nd dose", "DTaP : 3rd dose", "DTaP : 4th dose", "Hib : 1st dose", "Hib : 2nd dose", "Hib : 3rd dose", "Hib : 4th dose", "Pneumococcal Conjugate (PCV13) :  1st dose", "PCV13 :  2nd dose", "PCV13 : 3rd dose", "PCV13 : 4th dose", "Inactivated Polio Virus (IPV) : 1st dose", "IPV : subsequent booster doses", "Measles, Mumps, Rubella (MMR) : 1st dose", "Varicella (VAR) : 1st dose", "Hepatitis A (HepA) : 2-dose series"];
List<String> EighteenMonthsTo18Years = ["TDaP :  5th  dose", "Inactivated Polio : 4th dose", "Influenza(IIV) : Annual Vaccination", "MMR : 2nd dose", "VAR : 2nd dose", "TDaP : Tdap", "HPV : 2 dose series", "Meningococcal A : 2 dose", "Meningococcal B : 2 dose series", "Pneumococcal : 4 dose series"];
List<String> NineteenTo26 = ["Influenza Inactivated (IIV) : 1 annual dose", "TDaP : Booster dose every 10 years", "Human Papillomavirus (HPV):  1st dose", "HPV : 2nd dose", "Pneumococcal Conjugate :  1 dose", "Pneumococcal polysaccharide : 1st dose"];
List<String> TwentysevenTo49Years = ["Influenza(IIV) : 1 dose annually", "TDaP :  1 dose TDaP, booster every 10 years", "Pneumococcal conjugate : 1 dose", "Pneumococcal polysaccharide : 1 dose"];
List<String> FiftyTo64Years = ["Influenza(IIV) : 1 dose annually", "TDaP :  1 dose TDaP, booster every 10 years", "Zoster recombinant : 2 doses", "Pneumococcal conjugate : 1 dose", "Pneumococcal polysaccharide :  1 dose"];
List<String> GreaterThan65 = ["IIV : Annual dose", "Zoster Recombinant (RZV) : 2 doses", "Pneumococcal Polysaccaride (PPSV23) : 1 dose"];
List<Medicine> totalMedicines = [
  Medicine(salt: "Paracetamol",name: 'Crocin'),
  Medicine(salt: 'Acetaminophen',name: "Pain Relief"),
  Medicine(salt: "Paracetamol",name: 'Combiflam'),
  Medicine(salt:"Acetaminophen",name:'Tylenon'),Medicine(salt:"Acetaminophen",name:'Excedrin'),Medicine(salt:"Acetaminophen",name:'Panadol'),Medicine(salt:"Acetaminophen",name:'Calpol'),


  Medicine(salt:"Amoxicillin",name:'Augmentin'),Medicine(salt:"Amoxicillin",name:'Moxillin'),Medicine(salt:"Amoxicillin",name:'Amoxil'),Medicine(salt:"Amoxicillin",name:'Trimox'),


  Medicine(salt:"Azithral",name:'Azithral'),Medicine(salt:"Azithral",name:'Zathrin'),Medicine(salt:"Azithral",name:'Azimax'),Medicine(salt:"Azithral",name:'Zithromax'),


  Medicine(salt:"Benzonatate",name:'Tessalon'),Medicine(salt:"Benzonatate",name:'Zonatus'),


  Medicine(salt:"Ciprofloxacin",name:'Ciplox'),Medicine(salt:"Ciprofloxacin",name:'Floxip'),Medicine(salt:"Ciprofloxacin",name:'Cipro'),


  Medicine(salt:"Hydroxychloroquine",name:'Plaquenil'),Medicine(salt:"Hydroxychloroquine",name:'Hydroquin'),Medicine(salt:"Hydroxychloroquine",name:'Axemal'),Medicine(salt:"Hydroxychloroquine",name:'Dolquin'),


  Medicine(salt:"Ibuprofen",name:'Advil'),Medicine(salt:"Ibuprofen",name:'Motrin'),Medicine(salt:"Ibuprofen",name:'Nuprin'),

  Medicine (salt : "Lisinopril", name : 'Zestril'), Medicine (salt : "Lisinopril", name : 'Prinivil'), Medicine (salt : "Lisinopril", name : 'Qbrelis'),

  Medicine (salt : "Melatonin", name : 'Melatonin'),

  Medicine (salt : "Metformin", name : 'Metfaith'), Medicine (salt : "Metformin", name : 'Glucophage'), Medicine (salt : "Metformin", name : 'Fortamet'), Medicine (salt : "Metformin", name : 'Riomet'),

  Medicine (salt : "Methadone", name : 'Dolophine'), Medicine (salt : "Methadone", name : 'Methadone'),

  Medicine (salt : "Omeprazole", name : 'Omez'), Medicine (salt : "Omeprazole", name : 'Ocid'), Medicine (salt : "Omeprazole", name : 'Omee'),

  Medicine (salt : "Pantoprazole", name : 'Protonix'), Medicine (salt : "Pantoprazole", name : 'Pantocid'), Medicine (salt : "Pantoprazole", name : 'Pantop'),

  Medicine (salt : "Paracetamol", name : 'Tylenol'), Medicine (salt : "Paracetamol", name : 'Excedrin'),

  Medicine (salt : "Tramadol", name : 'Ultram'), Medicine (salt : "Tramadol", name : 'Domadol'), Medicine (salt : "Tramadol", name : 'Contramal'),

  Medicine (salt : "Wellbutrin", name : 'Zyban'), Medicine (salt : "Wellbutrin", name : 'Budeprion'), Medicine (salt : "Wellbutrin", name : 'Aplenzin'),

  Medicine (salt : "Zubsolv", name : 'Naloxone'), Medicine (salt : "Zubsolv", name : 'Buprenorphine'),

];

List<String> dosageList = ["Morning","Afternoon","Evening"];
List<String> days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];
