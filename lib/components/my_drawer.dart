import 'package:taskinity/auth/auth_service.dart';
import 'package:taskinity/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // logout method
  void logout() {
    // get auth service
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // logo
              DrawerHeader(
                child: Center(
                    child: Column(
                  children: [
                    // Icon(
                    //   Icons.task,
                    //   color: Theme.of(context).colorScheme.primary,
                    //   size: 60,
                    // ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'assets/images/logo-dark.png',
                        height: 60,
                        width: 60,
                      ),
                    ),
                    Text(
                      'By Abdul Sadath',
                      style: TextStyle(
                        fontSize: 20,
                        // color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                )),
              ),

              // // home list tile
              // Padding(
              //   padding: const EdgeInsets.only(left: 25.0),
              //   child: ListTile(
              //     leading: Icon(
              //       Icons.home,
              //       color: Theme.of(context).colorScheme.primary,
              //     ),
              //     title: Text('H O M E'),
              //     onTap: () {
              //       // Navigator.of(context).pushNamed('/home');
              //       // pop the drawer
              //       Navigator.pop(context);
              //     },
              //   ),
              // ),

              // settings list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text('S E T T I N G S'),
                  onTap: () {
                    // Navigator.of(context).pushNamed('/home');
                    // pop the drawer
                    Navigator.pop(context);

                    // navigate to settings page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // logout list tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text('L O G O U T'),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
