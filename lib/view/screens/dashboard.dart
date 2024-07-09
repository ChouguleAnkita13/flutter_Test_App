import 'package:flutter/material.dart';
import 'package:test_app/theme/app_theme.dart';
import 'package:test_app/view/widgets/home.dart';
import 'package:test_app/view/widgets/order.dart';
import 'package:test_app/view/widgets/profile.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key, required this.userDetails});
  final Map userDetails;

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = [
    const HomeScreen(),
    const OrderScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

//Dialog Box function for Logout
  void showLogoutDialogBox() {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: const Color.fromRGBO(0, 0, 0, 0.2),
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: AppTheme.primaryLightColor,
            shadowColor: const Color.fromRGBO(0, 0, 0, 0.15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            title: Text(widget.userDetails["name"],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge),
            content: Text("Are you sure you want to Logout from the screen?",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/login");
                },
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    fixedSize: const MaterialStatePropertyAll(Size(110, 35))),
                child: Text("Logout",
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    fixedSize: const MaterialStatePropertyAll(Size(110, 35)),
                    backgroundColor: const MaterialStatePropertyAll(
                        AppTheme.textColorLight)),
                child: Text("Cancel",
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        backgroundColor: AppTheme.primaryColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: showLogoutDialogBox,
            icon: const Icon(Icons.logout,
                color: AppTheme.primaryLightColor, size: 30),
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.primaryColor,
        selectedIconTheme: const IconThemeData(size: 28),
        selectedFontSize: 16,
        onTap: _onItemTapped,
      ),
    );
  }
}
