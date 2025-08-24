import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/features/chat/pages/chat_page.dart';
import 'package:scholar_chat/features/chat/cubit/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:scholar_chat/features/auth/pages/login_page.dart';
import 'package:scholar_chat/features/auth/pages/resgister_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage()
        },
        initialRoute: LoginPage.id,
      ),
    );
  }
}
