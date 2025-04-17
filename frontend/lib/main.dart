import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:isp_app/core/routes/router.dart';
import 'package:isp_app/core/services/firebase_service.dart';
import 'package:isp_app/features/authentication/presentation/auth/login_view.dart';
import 'package:isp_app/features/authentication/presentation/auth_controller.dart';
import 'package:isp_app/features/ticketing/presentation/help_center_view.dart';
import 'package:isp_app/features/order_internet/presentation/orders/history_view.dart';
import 'package:isp_app/features/user_management/presentation/profile/profile_view.dart';
import 'package:isp_app/features/user_management/presentation/dashboard_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  int currentViewIdx = 0;

  List<AppBar> _appBarList = [
    AppBar(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/person.jpg'),
      ),
      title: Text('Stefan Steakin'),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications),
        ),
      ],
    ),
    AppBar(
      title: Text('Riwayat'),
      centerTitle: false,
    ),
    AppBar(
      title: Text('Bantuan Pelayanan'),
      centerTitle: false,
    ),
    AppBar(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/person.jpg'),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Stefan Steakin'),
          Text('PR21040179901'),
        ],
      ),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.edit),
        ),
      ],
    ),
  ];

  List<Widget> _contentList = [
    DashboardView(),
    HistoryView(),
    HelpCenterView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      debugShowCheckedModeBanner: false,
      home: authController.currentUserLogin == null
          ? LoginView()
          : Scaffold(
              appBar: _appBarList.elementAt(currentViewIdx),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.black45,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.text_snippet),
                    label: 'Riwayat',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.help),
                    label: 'Bantuan',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
                currentIndex: currentViewIdx,
                onTap: (index) {
                  setState(() {
                    currentViewIdx = index;
                  });
                },
              ),
              body: _contentList.elementAt(currentViewIdx),
            ),
    );
  }
}
