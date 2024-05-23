import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/common/routes/router.dart';
import 'package:isp_app/common/widgets/error.dart';
import 'package:isp_app/features/auth/controller/auth_controller.dart';
import 'package:isp_app/features/auth/views/login_view.dart';
import 'package:isp_app/features/bantuan/views/bantuan_view.dart';
import 'package:isp_app/features/dashboard/views/dashboard_view.dart';
import 'package:isp_app/features/profile/views/profile_view.dart';
import 'package:isp_app/features/riwayat/views/riwayat_view.dart';
import 'firebase_options.dart';

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

  AppBar _generateAppBar() {
    switch (currentViewIdx) {
      case 0:
        return AppBar(
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
        );

      case 1:
        return AppBar(
          title: Text('Riwayat'),
          centerTitle: false,
        );

      case 2:
        return AppBar(
          title: Text('Bantuan Pelayanan'),
          centerTitle: false,
        );

      case 3:
        return AppBar(
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
        );
      default:
        return AppBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      debugShowCheckedModeBanner: false,
      home: ref.watch(userDataAuthProvider).when(
            data: (user) {
              if (user == null) {
                return const LoginView();
              }
              return Scaffold(
                appBar: _generateAppBar(),
                bottomNavigationBar: BottomNavigationBar(
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
                  onTap: (index) {
                    setState(() {
                      currentViewIdx = index;
                    });

                    switch (index) {
                      case 0:
                        DashboardView();
                        break;
                      case 1:
                        RiwayatView();
                        break;
                      case 2:
                        BantuanView();
                        break;
                      case 3:
                        ProfileView();
                        break;
                      default:
                    }
                  },
                ),
                body: const DashboardView(),
              );
            },
            error: (err, trace) {
              return ErrorView(error: err.toString());
            },
            loading: () => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
    );
  }
}
