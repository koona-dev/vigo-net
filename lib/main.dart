import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/common/routes/router.dart';
import 'package:isp_app/common/widgets/error.dart';
import 'package:isp_app/features/auth/controller/auth_controller.dart';
import 'package:isp_app/features/auth/views/login_view.dart';
import 'package:isp_app/features/dashboard/views/dashboard_view.dart';
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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              return const DashboardView();
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
