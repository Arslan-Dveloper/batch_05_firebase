import 'package:batch_05_firebase/Screenes/Authentication/screen_all_user.dart';
import 'package:batch_05_firebase/Screenes/Authentication/screen_input_data.dart';
import 'package:batch_05_firebase/Screenes/First/screen_input.dart';
import 'package:batch_05_firebase/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

void main() async {
  await GetStoragePro.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: ScreenInput(),
      home: FirebaseAuth.instance.currentUser == null
          ? ScreenInputData()
          : ScreenAllUser(),

      //home: ScreenInputData(),
    );
  }
}
