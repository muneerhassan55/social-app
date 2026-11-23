import 'package:sk_live_vice_group_chat/zego_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sk_live_vice_group_chat/firebase_options.dart';
import 'package:sk_live_vice_group_chat/views/auth/sign_in%20_screen.dart';
import 'package:sk_live_vice_group_chat/views/auth/sign_up_screen.dart';
import 'package:sk_live_vice_group_chat/views/home/base_screen.dart';
import 'package:sk_live_vice_group_chat/zim/zigoLogin.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

void main() async {
// ...
  await ZIMKit().init(
      appID: zegoAppId,
      appSign: zegoAppSign);
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: FirebaseAuth.instance.currentUser == null
      //     ? SignInScreen()
      //     : BaseScreen()
      home: ZigoLoginClass(),
    );
  }
}
