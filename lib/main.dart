import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meyochat/data/message_dao.dart';
import 'package:meyochat/data/user_dao.dart';
import 'package:meyochat/firebase_options.dart';
import 'package:meyochat/ui/login.dart';
import 'package:provider/provider.dart';
import 'ui/message_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          lazy: false,
          create: (context) => UserDao(),
        ),
        Provider(
          lazy: false,
          create: (context) => MessageDao(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RayChat',
        theme: ThemeData(primaryColor: const Color(0xFF3D814A)),
        home: Consumer<UserDao>(
          builder: (context, userDao, child) {
            return StreamBuilder<User?>(
              stream: context.read<UserDao>().authStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const MessageList();
                } else {
                  return const Login();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
