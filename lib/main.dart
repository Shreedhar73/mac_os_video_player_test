import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_realm_test/bloc/video_bloc.dart';
import 'package:flutter_realm_test/config/realm_config.dart';
import 'package:flutter_realm_test/controller/login/login_bloc.dart';
import 'package:flutter_realm_test/controller/realm/realm_bloc.dart';
import 'package:flutter_realm_test/controller/register/register_bloc.dart';
import 'package:flutter_realm_test/screens/video_full_screen.dart';
import 'package:media_kit/media_kit.dart';
import 'package:realm/realm.dart' as realm;

void main() {
  // RealmConfig.instance.localConfiguration();
  RealmConfig.instance.app = realm.App(
    realm.AppConfiguration('application-0-gcnnn'),
  );
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RealmBloc>(
          create: (context) => RealmBloc()..add(GetAllItemsEvent()),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<VideoBloc>(
          create: (context) => VideoBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          hoverColor: Colors.white,
        ),
        home: const VideoFullScreen(),
      ),
    );
  }
}
