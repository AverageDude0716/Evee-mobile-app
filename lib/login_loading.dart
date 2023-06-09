import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evee/landing_page.dart';
import 'package:evee/login.dart';
import 'package:evee/voter_dashboard.dart';
import 'package:evee/admin_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evee/firebase_functions.dart';
import 'styles.dart';


class Login_loading extends StatefulWidget
{

    @override
    State<Login_loading> createState() => _Login_loadinge_state();

}

class _Login_loadinge_state extends State<Login_loading>
{
  Firebase_func firebase_func = Firebase_func();
  final FirebaseAuth auth = FirebaseAuth.instance;

  void load(BuildContext context) async {
  User? user = auth.currentUser;
  String uid = 'none';

  if (user != null) {
    uid = user.uid;
  }

  try {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firebase_func.get_user_data(uid);
    if (documentSnapshot.exists) {
      // Access the document's data
      Map<String, dynamic> data = documentSnapshot.data()!;

      String account_type = data['account type'];

      switch (account_type) {
        case 'voter':
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Voter_dashboard_page()),
          );
          break;
        case 'admin':
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Admnin_dashboard_page()),
          );
          break;
      }
    } else {
      const SnackBar snackBar = SnackBar(
        content: Text('Error user does not exist'),
        behavior: SnackBarBehavior.floating,
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Login_page()));
    }
  } catch (error) {
    SnackBar snackBar = SnackBar(
      content: Text('Error: $error'),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}


  @override
  void initState() {
    super.initState();
    // Method called when the screen is created
    load(context);
  }


  @override
  Widget build(BuildContext context)
  {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return const Scaffold
    (

      body: Center
      (
       
        child: Text('Loading. Please wait.', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),

      ),

    );

  }

}