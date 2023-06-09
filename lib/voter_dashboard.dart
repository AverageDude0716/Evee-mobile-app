import 'package:evee/landing_page.dart';
import 'package:evee/settings_page.dart';
import 'package:evee/voter_home_page.dart';
import 'package:evee/voter_profie_page.dart';
import 'package:flutter/material.dart';
import 'styles.dart';


class Voter_dashboard_page extends StatefulWidget
{

    @override
    State<Voter_dashboard_page> createState() => _Voter_dashboard_page_state();

}

class _Voter_dashboard_page_state extends State<Voter_dashboard_page>
{

  int _selectedIndex = 0;  
  static final List<Widget> _widgetOptions = <Widget>
  [  

   Voter_home_page(),
   Voter_profile_page(),
   Settings_page(type: 'voter'),

  ];  

  
  void _onItemTapped(int index) 
  {  
    setState(() 
    {  
      _selectedIndex = index;  
    });  
  }  


  @override
  Widget build(BuildContext context)
  {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold
    (

      body: WillPopScope
      (
        onWillPop: ()async
        {
          return false;
        },

        child: Center
        (
        
          child: _widgetOptions.elementAt(_selectedIndex)

        ), 
      ),


      bottomNavigationBar:  BottomNavigationBar
      (  
        items: const <BottomNavigationBarItem>
        [  

          BottomNavigationBarItem(  
            icon: Icon(Icons.home),  
            label: 'Home',  
            backgroundColor: purple2 
          ), 

          BottomNavigationBarItem(  
            icon: Icon(Icons.person),  
            label: 'Profile',  
            backgroundColor: purple2
          ), 

          BottomNavigationBarItem(  
            icon: Icon(Icons.settings),  
            label: 'Settings',  
            backgroundColor: purple2
          ),  

        ], 

        type: BottomNavigationBarType.shifting,  
        currentIndex: _selectedIndex,  
        selectedItemColor: yellow,  
        iconSize: 40,  
        onTap: _onItemTapped,  
        elevation: 5  ,
      )

    );

  }

}