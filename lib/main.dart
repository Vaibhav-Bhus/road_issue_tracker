import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_aqua_cart/firebase_options.dart';
import 'package:test_aqua_cart/routes/routes.dart';
import 'package:test_aqua_cart/services/auth_services.dart';
import 'package:test_aqua_cart/services/issue_service.dart';
import 'package:test_aqua_cart/services/location_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MainApp());
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: false,
      designSize: const Size(428, 926),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            Provider(
              create: (_) => AuthService(auth: FirebaseAuth.instance),
            ),
            Provider(
              create: (_) => LocationService(),
            ),
            Provider(
              create: (_) => IssuesService(
                storage: FirebaseStorage.instance,
                firebaseFirestore: FirebaseFirestore.instance,
              ),
            ),
            StreamProvider<User?>(
              create: (context) => context.read<AuthService>().authStateChanges,
              initialData: null,
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            // theme: ThemeData(scaffoldBackgroundColor: const Color(0xff192028)),
            routerConfig: routes,
          ),
        );
      },
    );
  }
}
