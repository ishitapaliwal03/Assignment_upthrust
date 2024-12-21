import 'package:assignment/screens/Moviedetailpage.dart';
import 'package:assignment/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

// Main Screen with Navigation
class Navigationbarr extends StatefulWidget {
  @override
  _Navigationbarr createState() => _Navigationbarr();
}

class _Navigationbarr extends State<Navigationbarr> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    MovieDetailPage(),
    EventScreen(),
    TicketScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          _screens[_selectedIndex],

          // Bottom Navigation Bar
          Positioned(
            bottom: 8,
            left: 16,
            right: 16,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, 'Home', 0),
                  _buildNavItem(Icons.movie, 'Movie', 1),
                  _buildNavItem(Icons.calendar_today, 'Event', 2),
                  _buildNavItem(Icons.confirmation_number, 'My Ticket', 3),
                  _buildNavItem(Icons.person, 'Profile', 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 10,
          vertical: isSelected ? 8 : 6,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF6C3FE7) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
              size: isSelected ? 28 : 24,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontSize: isSelected ? 13 : 12,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Event Screen'));
  }
}

class TicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Ticket Screen'));
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Profile Screen'));
  }
}