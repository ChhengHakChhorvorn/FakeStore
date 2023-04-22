import 'dart:async';

import 'package:fake_store/data/response/user_response.dart';
import 'package:fake_store/screen/product_screen.dart';
import 'package:fake_store/screen/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'cart_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  UserResponse? user;

  HomeScreen({Key? key, this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

StreamController<bool> isLoggedIn = StreamController<bool>.broadcast();

Stream<bool> loginStream = isLoggedIn.stream;

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _buildScreens() {
    return [
      ProductScreen(
        user: widget.user,
      ),
      CartScreen(
        user: widget.user,
      ),
      ProfileScreen(
        user: widget.user,
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.bag_fill),
        title: ("Shop"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        title: ("Cart"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person_fill),
        title: ("Profile"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: CupertinoColors.black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null && widget.user == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {}
    });

    loginStream.listen((event) {
      if (event == false) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });

    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        navBarHeight: 60,
        confineInSafeArea: false,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        bottomScreenMargin: 0,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
        // Default is Colors.white.
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
      ),
    );
  }
}
